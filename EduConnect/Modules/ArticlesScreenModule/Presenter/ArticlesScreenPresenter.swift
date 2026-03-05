//
//  ArticlesScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

protocol ArticlesScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAccount()
    func didTapAppLogo()
    func didTapBack()
}

final class ArticlesScreenPresenter {
    // MARK: - VIPER
    weak var view: ArticlesScreenViewProtocol?
    var router: ArticlesScreenRouterProtocol
    var interactor: ArticlesScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    
    init(interactor: ArticlesScreenInteractorProtocol, router: ArticlesScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
}

extension ArticlesScreenPresenter: ArticlesScreenPresenterProtocol {
    func viewDidLoad() {
        let headerVM = ArticlesScreenHeaderCellViewModel()
        
        view?.applySnapshot(
            sections: [.header],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))]
            ]
        )
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didTapBack() {
        router.goBack()
    }
}
