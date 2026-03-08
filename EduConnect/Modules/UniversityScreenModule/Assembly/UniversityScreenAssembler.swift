//
//  UniversityScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

final class UniversityScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, filters: UniversityFilters? = nil) -> UniversityScreenVC {
        let interactor = UniversityScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = UniversityScreenRouter(appRouter: appRouter)
        let presenter = UniversityScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService, filters: filters)
        let viewController = UniversityScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
