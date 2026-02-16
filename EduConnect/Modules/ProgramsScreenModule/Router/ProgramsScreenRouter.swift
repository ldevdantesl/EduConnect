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
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func openSidebar() {
        appRouter.openSidebar()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
}
