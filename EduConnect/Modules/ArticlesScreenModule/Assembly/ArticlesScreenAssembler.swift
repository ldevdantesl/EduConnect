//
//  ArticlesScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

final class ArticlesScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol) -> ArticlesScreenVC {
        let interactor = ArticlesScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = ArticlesScreenRouter(appRouter: appRouter)
        let presenter = ArticlesScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService)
        let viewController = ArticlesScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
