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
    func routeToAnotherNews(news: ECNews)
    func routeToUniversity(universityID: Int)
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
    
    func routeToAnotherNews(news: ECNews) {
        let vc = ArticleDetailsScreenAssembler.assemble(appRouter: appRouter, article: news)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToUniversity(universityID: Int) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, universityID: universityID)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
