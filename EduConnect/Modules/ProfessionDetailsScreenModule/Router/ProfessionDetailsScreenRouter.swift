//
//  ProfessionDetailsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

protocol ProfessionDetailsScreenRouterProtocol {
    func openAccount()
    func routeToMain()
    func goBack()
    func routeToProfession(profession: ECProfession)
}

final class ProfessionDetailsScreenRouter: ProfessionDetailsScreenRouterProtocol {
    weak var viewController: ProfessionDetailsScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func routeToProfession(profession: ECProfession) {
        let vc = ProfessionDetailsScreenAssembler.assemble(appRouter: appRouter, professionID: profession.id)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
