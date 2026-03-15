//
//  ProgramsByCategoryScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramsByCategoryScreenRouterProtocol {
    func openAccount()
    func routeToMain()
    func goBack()
    func routeToDetails(program: ECProgram)
}

final class ProgramsByCategoryScreenRouter: ProgramsByCategoryScreenRouterProtocol {
    weak var viewController: ProgramsByCategoryScreenVC?
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
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToDetails(program: ECProgram) {
        let vc = ProgramDetailsScreenAssembler.assemble(appRouter: appRouter, programID: program.id)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
