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
    private var programCategories: [ECProgramCategory] = []
    private var universities: [ECUniversity] = []
    private let dispatchGroup = DispatchGroup()

    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func initialLoad() {
        let headerVM = MainScreenHeaderCellViewModel()
        let careersVM = MainScreenCareersCellViewModel(universities: universities)
        let programsVM = MainScreenProgramsCellViewModel(programs: programCategories)
        view?.applySnapshot(
            sections: [.header, .careers, .programs],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .careers : [.careersItem(.init(id: "careers", viewModel: careersVM))],
                .programs : [.programItem(.init(id: "programs", viewModel: programsVM))]
            ]
        )
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func viewDidLoad() {
        dispatchGroup.enter()
        interactor.getProgramCategories()
        
        dispatchGroup.enter()
        interactor.getAllUniversities()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.initialLoad()
        }
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didReceiveProgramCategories(categories: [ECProgramCategory]) {
        self.programCategories = categories
        dispatchGroup.leave()
    }
    
    func didReceiveUniversities(universities: [ECUniversity]) {
        var newUniversities = universities
        newUniversities.append(.sample)
        self.universities = newUniversities
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        view?.showError(errorMessage: userError.message)
    }
}
