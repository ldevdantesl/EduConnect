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
    
    private var programCategories: [ECProgramCategory] = []
    private var universities: [ECUniversity] = []
    private var professions: [ECProfession] = []
    
    private var selectedAcademicTab: MainScreenAcademicCellViewModel.AcademicTab = .programs

    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        let headerVM = MainScreenHeaderCellViewModel()
        let careersVM = MainScreenCareersCellViewModel(universities: universities)
        let programsVM = MainScreenProgramsCellViewModel(programs: programCategories)
        
        let sections: [MainScreenSection] = [.header, .careers, .programs, .academic]
        let itemsBySection: [MainScreenSection: [MainScreenItem]] = [
            .header: [.headerItem(.init(id: "header", viewModel: headerVM))],
            .careers: [.careersItem(.init(id: "careers", viewModel: careersVM))],
            .programs: [.programItem(.init(id: "programs", viewModel: programsVM))],
            .academic: buildAcademicItems()
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
                items.append(.academicUniversity(.init(id: "academic-uni-\(university.id)", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все наши вузы")
            items.append(.academicShowAll(.init(id: "academic-showAll", viewModel: showAllItem)))
            
        case .programs:
            programCategories.prefix(3).forEach { program in
                let vm = MainScreenAcademicProgramCellViewModel(program: program)
                items.append(.academicProgram(.init(id: "academic-program-\(program.id)", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все программы вузов")
            items.append(.academicShowAll(.init(id: "academic-showAll", viewModel: showAllItem)))
            
        case .professions:
            professions.prefix(3).forEach { profession in
                let vm = CardWithImageCellViewModel(
                    imageURL: profession.imageURL,
                    preTitle: "\(profession.programsCount) программ, \(profession.universitiesCount) вузов",
                    title: profession.name.ru,
                    subtitle: profession.description.ru,
                    showsArrowRight: true
                )
                items.append(.academicProfession(.init(id: "academic-profession-\(profession.id)", viewModel: vm)))
            }
            let showAllItem = MainScreenAcademicShowAllCellViewModel(title: "Показать все профессии вузов")
            items.append(.academicShowAll(.init(id: "academic-showAll", viewModel: showAllItem)))
        }
        
        return items
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
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.showError(errorMessage: userError.message)
    }
}
