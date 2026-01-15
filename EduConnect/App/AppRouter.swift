//
//  AppRouter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

final class AppRouter: AppRoutingProtocol {
    private let authState: ECAuthenticationProtocol
    
    init(authState: ECAuthenticationProtocol) {
        self.authState = authState
    }
    
    weak var window: UIWindow?
    
    private let navAnimator = NavigationAnimatorDelegate()
    private(set) var navController = UINavigationController()
    
    func start() {
        navController.delegate = navAnimator
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        authState.isLoggedIn ? routeToMain() : routeToAuthentication()
    }

    func routeToAuthentication() {
        let vc = LoginScreenAssembler.assemble(appRouter: self, authState: authState)
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToMain() {
        let vc = HomeScreenAssembler.assemble(appRouter: self)
        navController.setViewControllers([vc], animated: true)
    }
}
