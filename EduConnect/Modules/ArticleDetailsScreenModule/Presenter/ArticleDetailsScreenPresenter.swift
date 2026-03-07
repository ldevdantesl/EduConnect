//
//  ArticleDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

protocol ArticleDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAccount()
    func didTapAppLogo()
    func didTapBack()
}

final class ArticleDetailsScreenPresenter {
    // MARK: - VIPER
    weak var view: ArticleDetailsScreenViewProtocol?
    var router: ArticleDetailsScreenRouterProtocol
    var interactor: ArticleDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private let article: ECNews

    init(interactor: ArticleDetailsScreenInteractorProtocol, router: ArticleDetailsScreenRouterProtocol, article: ECNews, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
        self.article = article
    }
    
    
    private func applySnapshot() {
        let headerVM = ArticleDetailsHeaderCellViewModel(article: article)
        view?.applySnapshot(
            sections: [.header],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))]
            ]
        )
    }
}

extension ArticleDetailsScreenPresenter: ArticleDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        applySnapshot()
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
