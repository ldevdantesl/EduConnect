//
//  ArticlesScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

protocol ArticlesScreenRouterProtocol {
    func routeToMain()
    func openAccount()
    func goBack()
}

final class ArticlesScreenRouter: ArticlesScreenRouterProtocol {
    weak var viewController: ArticlesScreenVC?
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
