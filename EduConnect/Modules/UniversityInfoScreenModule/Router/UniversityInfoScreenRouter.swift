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
}

final class UniversityInfoScreenRouter: UniversityInfoScreenRouterProtocol {
    weak var viewController: UniversityInfoScreenVC?
    private let sidebarService: SidebarServiceProtocol
    private let appRouter: AppRoutingProtocol
    
    init(sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol) {
        self.sidebarService = sidebarService
        self.appRouter = appRouter
    }
    
    func openSidebar() {
        sidebarService.open()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
