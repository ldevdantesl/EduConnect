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
    func routeToCategory(category: ECProgramCategory)
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
    
    func routeToCategory(category: ECProgramCategory) {
        let vc = ProgramsByCategoryScreenAssembler.assemble(appRouter: appRouter, category: category)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
