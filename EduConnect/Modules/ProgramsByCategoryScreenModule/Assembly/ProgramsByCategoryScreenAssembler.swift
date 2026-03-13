//
//  ProgramsByCategoryScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

final class ProgramsByCategoryScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, category: ECProgramCategory) -> ProgramsByCategoryScreenVC {
        let interactor = ProgramsByCategoryScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = ProgramsByCategoryScreenRouter(appRouter: appRouter)
        let presenter = ProgramsByCategoryScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService, category: category)
        let viewController = ProgramsByCategoryScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
