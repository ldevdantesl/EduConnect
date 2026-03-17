//
//  MainScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
    
    func didReceiveProfessions(professions: [ECProfession])
    func didReceiveUniversities(universities: [ECUniversity])
    func didReceiveProgramCategories(categories: [ECProgramCategory])
    
    func didReceiveNewsTypes(types: [ECNewsType])
    func didReceiveNewsForType(news: [ECNews], typeID: Int?)
    func didReceiveAllNews(news: [ECNews])
    
    func didReceiveError(error: any Error)
}

final class MainScreenPresenter {
    // MARK: - VIPER
    weak var view: MainScreenViewProtocol?
    var router: MainScreenRouterProtocol
    var interactor: MainScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private let dispatchGroup = DispatchGroup()
    private var isInitialLoading: Bool = true
    
    private var selectedAcademicTab: MainScreenAcademicCellViewModel.AcademicTab = .programs
    private var selectedJournalTab: ECNewsType? = nil
    private var showingAllSteps: Bool = false
    
    private var programCategories: [ECProgramCategory] = []
    private var universities: [ECUniversity] = []
    private var professions: [ECProfession] = []
    
    private var newsTypes: [ECNewsType] = []
    private var allNews: [ECNews] = []
    private var newsByTypeId: [Int?: [ECNews]] = [:]
    
    private var programsCount: Int {
        programCategories.reduce(0) { $0 + ($1.programsCount ?? 0) }
    }
    
    private var universitiesCount: Int {
        universities.count
    }
    
    private var budgetPlacesCount: Int {
        universities.reduce(0) { $0 + $1.budgetPlaces }
    }
    
    // MARK: - SNAPSHOTING
    private let snapshotBuilder = MainScreenSnapshotBuilder()
    private lazy var actions = MainScreenSnapshotBuilder.Actions(
        didTapStepsENT: { [weak self] in self?.router.navigateToUniversities() },
        didTapStepsProfession: { [weak self] in self?.router.navigateToProfessions() },
        didTapStepsUniversity: { [weak self] in self?.router.navigateToUniversities() },
        didTapShowAllSteps: { [weak self] in self?.didTapShowAllSteps() },
        didTapUniversity: { [weak self] in self?.didTapUniversity(university: $0) },
        didTapProfession: { [weak self] in self?.router.navigateToProfession(profession: $0) },
        didTapProgramCategory: { [weak self] in self?.router.routeToProgramCategory(category: $0) },
        didTapArticle: { [weak self] in self?.router.routeToArticleDetails(article: $0) },
        didTapShowAllPrograms: { [weak self] in self?.didTapShowAllPrograms() },
        didTapShowAllProfessions: { [weak self] in self?.didTapShowAllProfessions() },
        didTapShowAllUniversities: { [weak self] in self?.didTapShowAllUniversities() },
        didTapShowAllArticles: { [weak self] in self?.router.navigateToAllArticles() },
        didTapServicesProfession: { [weak self] in self?.router.navigateToProfessions() },
        didTapServicesUniversity: { [weak self] in self?.router.navigateToUniversities() },
        didTapServicesCalendar: { [weak self] in self?.didTapCalendar() },
        didSelectAcademicTab: { [weak self] in self?.didSelectAcademicTab($0) },
        didSelectJournalType: { [weak self] in self?.didSelectJournalType($0) }
    )
    private var currentState: MainScreenSnapshotBuilder.State {
        MainScreenSnapshotBuilder.State(
            showingAllSteps: showingAllSteps,
            selectedAcademicTab: selectedAcademicTab,
            selectedJournalTab: selectedJournalTab,
            universities: universities,
            programCategories: programCategories,
            professions: professions,
            newsTypes: newsTypes,
            allNews: allNews,
            newsByTypeId: newsByTypeId,
            programsCount: programsCount,
            universitiesCount: universitiesCount,
            budgetPlacesCount: budgetPlacesCount
        )
    }
    
    // MARK: - INIT
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    // MARK: - PRIVATE FUNC
    private func applySnapshot(isLoadingOnJournals: Bool = false) {
        let result = snapshotBuilder.build(
            state: currentState,
            actions: actions,
            isLoadingOnJournals: isLoadingOnJournals
        )
        view?.applySnapshot(sections: result.sections, itemsBySection: result.items)
    }
    
    private func didSelectJournalType(_ type: ECNewsType?) {
        guard type?.id != selectedJournalTab?.id else { return }
        selectedJournalTab = type
        if let news = newsByTypeId[type?.id], news.count > 0 {
            applySnapshot()
        } else {
            applySnapshot(isLoadingOnJournals: true)
            interactor.getNewsForNewsType(typeID: type?.id)
        }
    }
    
    private func didSelectAcademicTab(_ tab: MainScreenAcademicCellViewModel.AcademicTab) {
        guard tab != selectedAcademicTab else { return }
        selectedAcademicTab = tab
        applySnapshot()
    }
    
    private func didTapShowAllSteps() {
        showingAllSteps.toggle()
        applySnapshot()
    }
    
    private func didTapShowAllPrograms() {
        self.router.navigateToPrograms()
    }
    
    private func didTapShowAllProfessions() {
        self.router.navigateToProfessions()
    }
    
    private func didTapShowAllUniversities() {
        self.router.navigateToUniversities()
    }
    
    private func didTapUniversity(university: ECUniversity) {
        self.router.navigateToUniversity(university: university)
    }
    
    private func didTapCalendar() {
        self.view?.scrollToSection(section: .journal) { [weak self] in
            let calendar = self?.newsTypes.first { $0.id == 1 }
            self?.didSelectJournalType(calendar)
        }
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func viewDidLoad() {
        self.view?.showLoading()
        dispatchGroup.enter()
        interactor.getProgramCategories()
        
        dispatchGroup.enter()
        interactor.getAllUniversities()
        
        dispatchGroup.enter()
        interactor.getProfessions()
        
        dispatchGroup.enter()
        interactor.getNewsTypes()
        
        dispatchGroup.enter()
        interactor.getAllNews()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.applySnapshot()
            self?.view?.hideLoading()
            self?.isInitialLoading = false
        }
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didReceiveProfessions(professions: [ECProfession]) {
        self.professions = professions
        dispatchGroup.leave()
    }
    
    func didReceiveProgramCategories(categories: [ECProgramCategory]) {
        self.programCategories = categories
        dispatchGroup.leave()
    }
    
    func didReceiveUniversities(universities: [ECUniversity]) {
        self.universities = universities
        dispatchGroup.leave()
    }
    
    // MARK: - NEWS
    func didReceiveNewsTypes(types: [ECNewsType]) {
        self.newsTypes = types
        dispatchGroup.leave()
    }
    
    func didReceiveAllNews(news: [ECNews]) {
        self.allNews = news
        self.newsByTypeId[nil] = news
        dispatchGroup.leave()
    }

    func didReceiveNewsForType(news: [ECNews], typeID: Int?) {
        newsByTypeId[typeID] = news
        applySnapshot()
    }
    
    // MARK: - ERROR
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.hideLoading()
        view?.showError(errorMessage: userError.message)
        guard isInitialLoading else { return }
        dispatchGroup.leave()
    }
}
