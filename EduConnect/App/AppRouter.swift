//
//  AppRouter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

final class AppRouter: AppRoutingProtocol {
    // MARK: - INJECTED PROPERTIES
    private let authState: ECAuthentication
    private var sidebarService: ECSidebarService
    
    // MARK: - WEAK PROPERTIES
    weak var window: UIWindow?
    
    // MARK: - PROPERTIES
    private let navAnimator = NavigationAnimatorDelegate()
    private(set) var navController = UINavigationController()
    private(set) var sidebarContainer: SidebarContainerViewController?
    
    init(authState: ECAuthentication, sidebarService: ECSidebarService) {
        self.authState = authState
        self.sidebarService = sidebarService
        setup()
    }
    
    // MARK: - PROTOCOL FUNC
    func start() {
        navController.navigationBar.isHidden = true
        navController.delegate = navAnimator
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        authState.isLoggedIn ? routeToAccount() : routeToAuthentication()
    }

    func routeToAuthentication() {
        let vc = LoginScreenAssembler.assemble(appRouter: self, authState: authState)
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToAccount() {
        sidebarContainer = SidebarContainerViewController(
            rootViewController: navController,
            sidebarService: sidebarService
        )
        window?.rootViewController = sidebarContainer
        window?.makeKeyAndVisible()
        let vc = AccountScreenAssembler.assemble(appRouter: self, sidebarService: sidebarService)
        navController.setViewControllers([vc], animated: true)
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        sidebarService.onTabSelected = { [weak self] in
            guard let self = self else { return }
            self.navigateFromSidebar(to: $0)
        }
    }
    
    private func navigateFromSidebar(to tab: SidebarMenuTab) {
        switch tab {
        case .universities:
            let vc = UniversityScreenAssembler.assemble(sidebarService: sidebarService, appRouter: self)
            navController.setViewControllers([vc], animated: true)
        case .programs:  print("Navigating to Programs")
        case .professions: print("Navigating to Professions")
        case .tests: print("Navigating to Tests")
        case .article: print("Navigating to Artcles")
        case .calendar: print("Navigating to Calendar")
        case .none: print("Not navigating")
        }
    }
}
