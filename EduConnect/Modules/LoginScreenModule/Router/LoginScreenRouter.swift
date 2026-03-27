//
//  LoginScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit

protocol LoginScreenRouterProtocol {
    func routeToAccountScreen()
    func routeToMainScreen()
    func routeToForgotPassword()
}

final class LoginScreenRouter: LoginScreenRouterProtocol {
    weak var viewController: LoginScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func routeToAccountScreen() {
        appRouter.routeToAccount()
    }
    
    func routeToMainScreen() {
        appRouter.routeToMain()
    }
    
    func routeToForgotPassword() {
        let vc = ForgotPasswordScreenAssembler.assemble(appRouter: appRouter)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
