//
//  MainScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit

final class MainScreenAssembler {
    static func assemble(
        sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol,
        networkService: NetworkServiceProtocol, errorService: ErrorServiceProtocol,
    ) -> MainScreenVC {
        let interactor = MainScreenInteractor(networkService: networkService)
        let router = MainScreenRouter(sidebarService: sidebarService, appRouter: appRouter)
        let presenter = MainScreenPresenter(interactor: interactor, router: router, errorService: errorService)
        let viewController = MainScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
