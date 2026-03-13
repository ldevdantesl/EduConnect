//
//  ProgramDetailsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

final class ProgramDetailsScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, programID: Int) -> ProgramDetailsScreenVC {
        let interactor = ProgramDetailsScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = ProgramDetailsScreenRouter(appRouter: appRouter)
        let presenter = ProgramDetailsScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService, programID: programID)
        let viewController = ProgramDetailsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
