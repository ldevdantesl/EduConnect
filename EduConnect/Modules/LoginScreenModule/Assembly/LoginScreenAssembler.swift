//
//  LoginScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit

final class LoginScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol) -> LoginScreenVC {
        let interactor = LoginScreenInteractor(authentication: appRouter.diContainer.authentication)
        let router = LoginScreenRouter(appRouter: appRouter)
        let presenter = LoginScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService)
        let viewController = LoginScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
