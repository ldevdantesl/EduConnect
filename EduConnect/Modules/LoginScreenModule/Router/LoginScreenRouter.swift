//
//  LoginScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit

protocol LoginScreenRouterProtocol {
    func routeToMainScreen()
}

final class LoginScreenRouter: LoginScreenRouterProtocol {
    weak var viewController: LoginScreenVC?
    weak var appRouter: AppRoutingProtocol?
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func routeToMainScreen() {
        appRouter?.routeToMain()
    }
}
