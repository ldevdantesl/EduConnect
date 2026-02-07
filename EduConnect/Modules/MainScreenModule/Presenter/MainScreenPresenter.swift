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
    
    func didReceiveProfessions(professions: [ECReferenceProfession])
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
    private var professions: [ECReferenceProfession] = []
    
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
        items.append(.academicItem(.init(id: "academic", viewModel: headerVM)))
        
        switch selectedAcademicTab {
        case .universities:
            for university in universities {
                let vm = UniversityCellViewModel(university: university, horizontallySpaced: true)
                items.append(.academicUniversity(.init(id: "academic-uni-\(university.id)", viewModel: vm)))
            }
            
        case .programs:
            for program in programCategories {
                let vm = CardWithImageCellViewModel(
                    imageURL: program.iconURL,
                    preTitle: "\(program.programsCount) программ",
                    title: program.name.ru
                )
                items.append(.academicProgram(.init(id: "academic-program-\(program.id)", viewModel: vm)))
            }
            
        case .professions:
            for profession in professions {
                let vm = CardWithImageCellViewModel(
                    imageURL: profession.image,
                    title: profession.name.ru,
                    subtitle: profession.description.ru
                )
                items.append(.academicProfession(.init(id: "academic-profession-\(profession.id)", viewModel: vm)))
            }
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
    
    func didReceiveProfessions(professions: [ECReferenceProfession]) {
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
