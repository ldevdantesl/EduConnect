//
//  ProgramsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

protocol ProgramsScreenRouterProtocol {
    func openSidebar() 
    func openAccount()
    func routeToMain()
}

final class ProgramsScreenRouter: ProgramsScreenRouterProtocol {
    weak var viewController: ProgramsScreenVC?
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
    
    func routeToMain() {
        appRouter.routeToMain()
    }
}
