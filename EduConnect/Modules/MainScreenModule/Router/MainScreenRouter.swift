//
//  MainScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit

protocol MainScreenRouterProtocol {
    func openSidebar()
    func openAccount()
    func goBack()
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenVC?
    private let sidebarService: SidebarServiceProtocol
    private let appRouter: AppRoutingProtocol
    
    init(sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol) {
        self.sidebarService = sidebarService
        self.appRouter = appRouter
    }
    
    func openSidebar() {
        sidebarService.open()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
