//
//  ProfessionsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

import UIKit

protocol ProfessionsScreenRouterProtocol {
    func openSidebar()
    func openAccount()
    func routeToMain()
    func routeToProfession(professionID: Int)
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
    
    func routeToProfession(professionID: Int) {
        let vc = ProfessionDetailsScreenAssembler.assemble(appRouter: appRouter, professionID: professionID)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
