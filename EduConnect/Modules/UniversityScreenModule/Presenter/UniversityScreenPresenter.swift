//
//  UniversityScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import SnapKit

protocol UniversityScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class UniversityScreenPresenter {
    weak var view: UniversityScreenViewProtocol?
    var router: UniversityScreenRouterProtocol
    var interactor: UniversityScreenInteractorProtocol

    init(interactor: UniversityScreenInteractorProtocol, router: UniversityScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension UniversityScreenPresenter: UniversityScreenPresenterProtocol {
    func viewDidLoad() {
        let headerVM = UniversityScreenHeaderCellViewModel()
        let filtersVM = UniversityScreenFilterCellViewModel()
        view?.applySnapshot(
            sections: [.headerInfo],
            itemsBySection: [
                .headerInfo: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .filterItem(.init(id: "filter", viewModel: filtersVM))
                ]
            ]
        )
    }
}
