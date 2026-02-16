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
    func navigateToUniversities()
    func navigateToProfessions()
    func navigateToPrograms()
    func navigateToUniversity(university: ECUniversity)
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenVC?
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
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToUniversity(university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, university: university)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPrograms() {
        let vc = ProgramsScreenAssembler.assemble(appRouter: appRouter)
        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func navigateToProfessions() {
        let vc = ProfessionsScreenAssembler.assemble(appRouter: appRouter)
        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func navigateToUniversities() {
        let vc = UniversityScreenAssembler.assemble(appRouter: appRouter)
        viewController?.navigationController?.setViewControllers([vc], animated: true)
    }
}
