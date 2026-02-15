//
//  ProgramsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

final class ProgramsScreenAssembler {
    static func assemble(
        appRouter: AppRoutingProtocol,
        networkService: NetworkServiceProtocol, errorService: ErrorServiceProtocol
    ) -> ProgramsScreenVC {
        let interactor = ProgramsScreenInteractor(networkService: networkService)
        let router = ProgramsScreenRouter(appRouter: appRouter)
        let presenter = ProgramsScreenPresenter(interactor: interactor, router: router, errorService: errorService)
        let viewController = ProgramsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
