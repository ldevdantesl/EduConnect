//
//  ArticleDetailsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

protocol ArticleDetailsScreenRouterProtocol {
    func routeToMain()
    func openAccount()
    func goBack()
}

final class ArticleDetailsScreenRouter: ArticleDetailsScreenRouterProtocol {
    weak var viewController: ArticleDetailsScreenVC?
    
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
