//
//  AppRouter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

protocol AppRoutingProtocol: AnyObject {
    var diContainer: DIContainer { get }
    func start()
    func routeToAuthentication()
    func routeToAccount()
    func routeToMain()
    func openSidebar()
}

final class AppRouter: AppRoutingProtocol {
    // MARK: - INJECTED PROPERTIES
    let diContainer: DIContainer
    private let authState: ECAuthentication
    private let networkService: ECNetworkService
    private let errorService: ECErrorService
    private let sidebarService: ECSidebarService
    
    // MARK: - WEAK PROPERTIES
    weak var window: UIWindow?
    
    // MARK: - PROPERTIES
    private let navAnimator = NavigationAnimatorDelegate()
    private(set) var navController = UINavigationController()
    private(set) var sidebarContainer: SidebarContainerViewController?
    
    init(diContainer: DIContainer) {
        self.diContainer = diContainer
        self.authState = diContainer.authentication
        self.sidebarService = diContainer.sidebarService
        self.networkService = diContainer.networkService
        self.errorService = diContainer.errorService
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
        let vc = LoginScreenAssembler.assemble(appRouter: self)
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToAccount() {
        sidebarContainer?.setSidebarEnabled(true)
        let vc = AccountScreenAssembler.assemble(appRouter: self)
        navController.setViewControllers([vc], animated: true)
    }
    
    func routeToMain() {
        sidebarContainer?.setSidebarEnabled(true)
        let vc = MainScreenAssembler.assemble(appRouter: self)
        navController.setViewControllers([vc], animated: true)
    }
    
    func openSidebar() {
        sidebarService.open()
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
            let vc = UniversityScreenAssembler.assemble(appRouter: self)
            navController.setViewControllers([vc], animated: true)
        case .programs:
            let vc = ProgramsScreenAssembler.assemble(appRouter: self)
            navController.setViewControllers([vc], animated: true)
            
        case .main:
            let vc = MainScreenAssembler.assemble(appRouter: self)
            navController.setViewControllers([vc], animated: true)
            
        case .professions:
            let vc = ProfessionsScreenAssembler.assemble(appRouter: self)
            navController.setViewControllers([vc], animated: true)
            
        case .logout:
            Task { [weak self] in
                guard let self else { return }
                self.sidebarService.container?.showHoverLoading()
                do {
                    try await authState.logOut()
                    self.routeToAuthentication()
                    self.sidebarService.container?.hideHoverLoading()
                } catch {
                    let userFacingError = self.errorService.handle(error)
                    self.sidebarService.container?.showToastedError(userError: userFacingError)
                    self.sidebarContainer?.hideHoverLoading()
                }
            }
            
        case .changeLanguage:
            self.sidebarService.container?.showAlert(message: ConstantLocalizedStrings.Sidebar.changeLanguageNotice) {
                ECAppOpener.openSettings()
            }
        }
    }
}
