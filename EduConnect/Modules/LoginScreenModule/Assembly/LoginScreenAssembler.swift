//
//  LoginScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit

final class LoginScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol, authentication: AuthenticationProtocol, errorService: ErrorServiceProtocol) -> LoginScreenVC {
        let interactor = LoginScreenInteractor(authentication: authentication)
        let router = LoginScreenRouter(appRouter: appRouter)
        let presenter = LoginScreenPresenter(interactor: interactor, router: router, errorService: errorService)
        let viewController = LoginScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
