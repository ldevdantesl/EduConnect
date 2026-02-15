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
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func openSidebar() {
        appRouter.sidebarService.open()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
