//
//  ProfessionsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

import UIKit

final class ProfessionsScreenAssembler {
    static func assemble(
        appRouter: AppRoutingProtocol,
        networkService: NetworkServiceProtocol, errorService: ErrorServiceProtocol
    ) -> ProfessionsScreenVC {
        let interactor = ProfessionsScreenInteractor(networkService: networkService)
        let router = ProfessionsScreenRouter(appRouter: appRouter)
        let presenter = ProfessionsScreenPresenter(interactor: interactor, router: router, errorService: errorService)
        let viewController = ProfessionsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
