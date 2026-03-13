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
}
