//
//  AppRouter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

final class AppRouter {
    static let shared = AppRouter()
    
    private init() { }
    
    weak var window: UIWindow?
    
    private let navAnimator = NavigationAnimatorDelegate()
    private(set) var navController = UINavigationController()
    
    func start() {
        navController.delegate = navAnimator
        let vc = LoginScreenAssembler.assemble()
        navController.setViewControllers([vc], animated: true)
    }
    
    func showHome() {
        let vc = HomeScreenAssembler.assemble()
        navController.setViewControllers([vc], animated: true)
    }
}
