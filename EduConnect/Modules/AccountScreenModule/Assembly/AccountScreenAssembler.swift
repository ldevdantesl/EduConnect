//
//  HomeScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

final class AccountScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, sidebarService: SidebarServiceProtocol) -> AccountScreenVC {
        let interactor = AccountScreenInteractor()
        let router = AccountScreenRouter(appRouter: appRouter, sidebarService: sidebarService)
        let presenter = AccountScreenPresenter(interactor: interactor, router: router)
        let viewController = AccountScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
