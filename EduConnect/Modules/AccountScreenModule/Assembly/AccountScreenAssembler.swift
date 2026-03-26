//
//  HomeScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

final class AccountScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol) -> AccountScreenVC {
        let interactor = AccountScreenInteractor(
            networkService: appRouter.diContainer.networkService,
            authService: appRouter.diContainer.authentication
        )
        let router = AccountScreenRouter(appRouter: appRouter)
        let presenter = AccountScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService)
        let viewController = AccountScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
