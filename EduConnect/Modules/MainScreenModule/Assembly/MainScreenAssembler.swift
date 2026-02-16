//
//  MainScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit

final class MainScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol) -> MainScreenVC {
        let interactor = MainScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = MainScreenRouter(appRouter: appRouter)
        let presenter = MainScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService)
        let viewController = MainScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
