//
//  UniversityInfoScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

final class UniversityInfoScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, university: ECUniversity) -> UniversityInfoScreenVC {
        let interactor = UniversityInfoScreenInteractor(networkService: appRouter.diContainer.networkService)
        let router = UniversityInfoScreenRouter(appRouter: appRouter)
        let presenter = UniversityInfoScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService, university: university)
        let viewController = UniversityInfoScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
