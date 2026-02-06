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
}

final class MainScreenPresenter {
    weak var view: MainScreenViewProtocol?
    var router: MainScreenRouterProtocol
    var interactor: MainScreenInteractorProtocol
    private let errorService: ErrorServiceProtocol

    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    func viewDidLoad() {
        let headerVM = MainScreenHeaderCellViewModel()
        let careersVM = MainScreenCareersCellViewModel(universities: [.sample, .sample, .sample, .sample])
        view?.applySnapshot(
            sections: [.header, .careers],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .careers : [.careersItem(.init(id: "careers", viewModel: careersVM))]
            ]
        )
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
}
