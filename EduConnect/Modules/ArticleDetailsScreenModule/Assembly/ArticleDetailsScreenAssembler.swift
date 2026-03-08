//
//  ArticleDetailsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

final class ArticleDetailsScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, article: ECNews) -> ArticleDetailsScreenVC {
        let interactor = ArticleDetailsScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = ArticleDetailsScreenRouter(appRouter: appRouter)
        let presenter = ArticleDetailsScreenPresenter(interactor: interactor, router: router, article: article, errorService: appRouter.diContainer.errorService)
        let viewController = ArticleDetailsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
