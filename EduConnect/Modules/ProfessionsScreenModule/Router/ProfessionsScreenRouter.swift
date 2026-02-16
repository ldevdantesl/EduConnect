//
//  ProfessionsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenRouterProtocol {
    func openSidebar()
    func openAccount()
    func routeToMain()
}

final class ProfessionsScreenRouter: ProfessionsScreenRouterProtocol {
    weak var viewController: ProfessionsScreenVC?
    
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
