//
//  AppRouter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

protocol AppRoutingProtocol: AnyObject {
    func start()
    func routeToAuthentication()
    func routeToAccount()
    func routeToMain()
    var sidebarService: ECSidebarService { get }
}

final class AppRouter: AppRoutingProtocol {
    // MARK: - INJECTED PROPERTIES
    private let authState: ECAuthentication
    private let networkService: ECNetworkService
    private let errorService: ECErrorService
    let sidebarService: ECSidebarService
    
    // MARK: - WEAK PROPERTIES
    weak var window: UIWindow?
    
    // MARK: - PROPERTIES
    private let navAnimator = NavigationAnimatorDelegate()
    private(set) var navController = UINavigationController()
    private(set) var sidebarContainer: SidebarContainerViewController?
    
    init(authState: ECAuthentication, sidebarService: ECSidebarService, networkService: ECNetworkService, errorService: ECErrorService) {
        self.authState = authState
        self.sidebarService = sidebarService
        self.networkService = networkService
        self.errorService = errorService
        setup()
    }
    
    // MARK: - PROTOCOL FUNC
    func start() {
        navController.navigationBar.isHidden = true
        navController.delegate = navAnimator
        
        sidebarContainer = SidebarContainerViewController(
            rootViewController: navController,
            sidebarService: sidebarService
        )
        
        sidebarService.container = sidebarContainer
        
        window?.rootViewController = sidebarContainer
        window?.makeKeyAndVisible()
        
        authState.isLoggedIn ? routeToAccount() : routeToAuthentication()
    }

    func routeToAuthentication() {
        sidebarContainer?.setSidebarEnabled(false)
        let vc = LoginScreenAssembler.assemble(appRouter: self, authentication: authState, errorService: errorService)
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToAccount() {
        sidebarContainer?.setSidebarEnabled(true)
        let vc = AccountScreenAssembler.assemble(
            appRouter: self,
            networkService: networkService, errorService: errorService
        )
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToMain() {
        sidebarContainer?.setSidebarEnabled(true)
        let vc = MainScreenAssembler.assemble(
            appRouter: self,
            networkService: networkService, errorService: errorService
        )
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
            let vc = UniversityScreenAssembler.assemble(appRouter: self, networkService: networkService, errorService: errorService)
            navController.setViewControllers([vc], animated: true)
        case .programs:
            let vc = ProgramsScreenAssembler.assemble(appRouter: self, networkService: networkService, errorService: errorService)
            navController.setViewControllers([vc], animated: true)
            
        case .main:
            let vc = MainScreenAssembler.assemble(appRouter: self, networkService: networkService, errorService: errorService)
            navController.setViewControllers([vc], animated: true)
            
        case .professions:
            let vc = ProfessionsScreenAssembler.assemble(appRouter: self, networkService: networkService, errorService: errorService)
            navController.setViewControllers([vc], animated: true)
            
        case .none: print("Not navigating")
        }
    }
}
