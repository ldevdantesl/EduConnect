//
//  ProfessionDetailsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

final class ProfessionDetailsScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, professionID: Int) -> ProfessionDetailsScreenVC {
        let interactor = ProfessionDetailsScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = ProfessionDetailsScreenRouter(appRouter: appRouter)
        let presenter = ProfessionDetailsScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService, professionID: professionID)
        let viewController = ProfessionDetailsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
