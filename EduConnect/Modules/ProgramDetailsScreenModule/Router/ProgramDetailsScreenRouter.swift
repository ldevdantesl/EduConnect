//
//  ProgramDetailsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramDetailsScreenRouterProtocol {
    func openAccount()
    func routeToMain()
    func goBack()
    func routeToUniversity(university: ECUniversity)
    func routeToProgram(program: ECProgram)
}

final class ProgramDetailsScreenRouter: ProgramDetailsScreenRouterProtocol {
    weak var viewController: ProgramDetailsScreenVC?
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
    
    func routeToUniversity(university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, university: university)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToProgram(program: ECProgram) {
        let vc = ProgramDetailsScreenAssembler.assemble(appRouter: appRouter, programID: program.id)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
