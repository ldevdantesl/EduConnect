//
//  UniversityInfoScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenRouterProtocol {
    func openAccount()
    func goBack()
    func routeToMain()
    func routeToProfession(professionID: Int)
}

final class UniversityInfoScreenRouter: UniversityInfoScreenRouterProtocol {
    weak var viewController: UniversityInfoScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func routeToProfession(professionID: Int) {
        let vc = ProfessionDetailsScreenAssembler.assemble(appRouter: appRouter, professionID: professionID)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
