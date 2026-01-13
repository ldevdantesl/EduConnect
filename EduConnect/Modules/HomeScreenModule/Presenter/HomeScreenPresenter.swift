//
//  HomeScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class HomeScreenPresenter {
    weak var view: HomeScreenViewProtocol?
    var router: HomeScreenRouterProtocol
    var interactor: HomeScreenInteractorProtocol

    init(interactor: HomeScreenInteractorProtocol, router: HomeScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    func viewDidLoad() {
        let university = ECUniversity.sample
        let viewModel = HomeScreenUniversityCellViewModel(university: university)
        self.view?.applySnapshot(
            sections: [.universities],
            itemsBySection: [
                .universities : [
                    .university(DiffableItem(id: university.id, viewModel: viewModel)),
                    .university(DiffableItem(id: UUID(), viewModel: viewModel))
                ]
            ]
        )
    }
}
