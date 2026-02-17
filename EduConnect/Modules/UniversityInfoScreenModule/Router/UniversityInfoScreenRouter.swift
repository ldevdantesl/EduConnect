//
//  UniversityInfoScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenRouterProtocol {
    func openSidebar()
    func openAccount()
    func goBack()
    func routeToMain()
}

final class UniversityInfoScreenRouter: UniversityInfoScreenRouterProtocol {
    weak var viewController: UniversityInfoScreenVC?
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
    
    func routeToMain() {
        appRouter.routeToMain()
    }
}
