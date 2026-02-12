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
    
    private var selectedAcademicTab: MainScreenAcademicCellViewModel.AcademicTab = .programs
    private var selectedJournalTab: ECNewsType? = nil
    
    private var programCategories: [ECProgramCategory] = []
    private var universities: [ECUniversity] = []
    private var professions: [ECProfession] = []
    
    private var newsTypes: [ECNewsType] = []
    private var allNews: [ECNews] = []
    private var newsByTypeId: [Int?: [ECNews]] = [:]

    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot(isLoadingOnJournals: Bool = false) {
        let headerVM = MainScreenHeaderCellViewModel()
        let careersVM = MainScreenCareersCellViewModel(universities: universities)
        let programsVM = MainScreenProgramsCellViewModel(programs: programCategories)
        let servicesVM = MainScreenServicesCellViewModel()
        let footerVM = MainScreenFooterCellViewModel()
        
        let sections: [MainScreenSection] = [.header, .careers, .programs, .academic, .services, .journal, .footer]
        let itemsBySection: [MainScreenSection: [MainScreenItem]] = [
            .header: [.headerItem(.init(id: "header", viewModel: headerVM))],
            .careers: [.careersItem(.init(id: "careers", viewModel: careersVM))],
            .programs: [.programItem(.init(id: "programs", viewModel: programsVM))],
            .academic: buildAcademicItems(),
            .services: [.servicesItem(.init(id: "services", viewModel: servicesVM))],
            .journal: buildJournalItems(isLoading: isLoadingOnJournals),
            .footer: [.footerItem(.init(id: "footer", viewModel: footerVM))]
        ]
        
        view?.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    private func buildAcademicItems() -> [MainScreenItem] {
        var items: [MainScreenItem] = []
        
        let headerVM = MainScreenAcademicCellViewModel(selectedTab: selectedAcademicTab) { [weak self] tab in
            self?.didSelectAcademicTab(tab)
        }
        items.append(.academicItem(.init(viewModel: headerVM)))
        
        switch selectedAcademicTab {
        case .universities:
            universities.prefix(3).forEach { university in
                let vm = CardWithImageCellViewModel(
                    imageURL: university.mainImageURL,
                    preTitle: "\(university.city.name) / \(university.programsCount) программ",
                    title: university.name,
                    showsArrowRight: true
                )
                items.append(.cardWithImageItem(.init(item: university, prefix: "academic-uni", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все наши вузы")
            items.append(.academicShowAll(.init(viewModel: showAllItem)))
            
        case .programs:
            programCategories.prefix(3).forEach { program in
                let vm = MainScreenAcademicProgramCellViewModel(program: program)
                items.append(.academicProgram(.init(item: program, prefix: "academic-program", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все программы вузов")
            items.append(.academicShowAll(.init(viewModel: showAllItem)))
            
        case .professions:
            professions.prefix(3).forEach { profession in
                let vm = CardWithImageCellViewModel(
                    imageURL: profession.imageURL,
                    preTitle: "\(profession.programsCount) программ, \(profession.universitiesCount) вузов",
                    title: profession.name.ru,
                    subtitle: profession.description.ru,
                    showsArrowRight: true
                )
                items.append(.cardWithImageItem(.init(item: profession, prefix: "academic-profession-", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все профессии вузов")
            items.append(.academicShowAll(.init(viewModel: showAllItem)))
        }
        
        return items
    }
    
    private func buildJournalItems(isLoading: Bool = false) -> [MainScreenItem] {
        var items: [MainScreenItem] = []
        
        let headerVM = MainScreenJournalCellViewModel(
            selectedType: selectedJournalTab,
            allTypes: newsTypes
        ) { [weak self] type in
            self?.didSelectJournalType(type)
        }
        items.append(.journalItem(.init(viewModel: headerVM)))
        
        guard !isLoading else {
            let loadingVM = LoadingCellViewModel()
            items.append(.loadingItem(.init(viewModel: loadingVM)))
            return items
        }
        let newsToShow: [ECNews]
        if let selectedType = selectedJournalTab {
            newsToShow = newsByTypeId[selectedType.id] ?? []
        } else {
            newsToShow = allNews
        }
        
        newsToShow.prefix(5).forEach { news in
            let vm = CardWithImageCellViewModel(
                imageURL: news.previewImageURL,
                preTitle: news.newsType.name.ru,
                title: news.title.ru,
                subtitle: news.shortDescription.ru,
                showsArrowRight: true
            )
            items.append(.cardWithImageItem(.init(item: news, prefix: "journal-news", viewModel: vm)))
        }
        
        let underlineVM = UnderlineButtonCellViewModel(
            titleName: "Посмотреть все новости",
            titleSize: 14, titleColor: .darkGray, onTapAction: nil
        )
        items.append(.underlineButtonItem(.init(id: "underlineButton", viewModel: underlineVM)))
        return items
    }
    
    private func didSelectJournalType(_ type: ECNewsType?) {
        guard type?.id != selectedJournalTab?.id else { return }
        selectedJournalTab = type
        if let news = newsByTypeId[type?.id], news.count > 0 {
            self.didReceiveNewsForType(news: news, typeID: type?.id)
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
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func viewDidLoad() {
        dispatchGroup.enter()
        interactor.getProgramCategories()
        
        dispatchGroup.enter()
        interactor.getAllUniversities()
        
        dispatchGroup.enter()
        interactor.getProfessions()
        
        dispatchGroup.enter()
        interactor.getNewsTypes()
        
        dispatchGroup.enter()
        interactor.getNewsTypes()
        
        dispatchGroup.enter()
        interactor.getAllNews()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.applySnapshot()
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
        dispatchGroup.leave()
    }

    func didReceiveNewsForType(news: [ECNews], typeID: Int?) {
        newsByTypeId[typeID] = news
        applySnapshot()
    }
    
    // MARK: - ERROR
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.showError(errorMessage: userError.message)
    }
}
