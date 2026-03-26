//
//  ForgotPasswordScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

final class ForgotPasswordScreenAssembler {
    static func assemble(appRouter: AppRoutingProtocol) -> ForgotPasswordScreenVC {
        let interactor = ForgotPasswordScreenInteractor(authService: appRouter.diContainer.authentication)
        let router = ForgotPasswordScreenRouter(appRouter: appRouter)
        let presenter = ForgotPasswordScreenPresenter(interactor: interactor, router: router, errorService: appRouter.diContainer.errorService)
        let viewController = ForgotPasswordScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
