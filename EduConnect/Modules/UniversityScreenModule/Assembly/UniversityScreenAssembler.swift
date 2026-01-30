//
//  UniversityScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

final class UniversityScreenAssembler {
    static func assemble(
        sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol,
        networkService: NetworkServiceProtocol, errorService: ErrorServiceProtocol
    ) -> UniversityScreenVC {
        let interactor = UniversityScreenInteractor(networkService: networkService)
        let router = UniversityScreenRouter(sidebarService: sidebarService, appRouter: appRouter, networkService: networkService, errorService: errorService)
        let presenter = UniversityScreenPresenter(interactor: interactor, router: router, errorService: errorService)
        let viewController = UniversityScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
