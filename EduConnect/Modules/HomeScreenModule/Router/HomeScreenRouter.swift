//
//  HomeScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

protocol HomeScreenRouterProtocol {
}

final class HomeScreenRouter: HomeScreenRouterProtocol {
    weak var viewController: HomeScreenVC?
    weak var appRoter: AppRoutingProtocol?
    
    init(appRouter: AppRoutingProtocol) {
        self.appRoter = appRouter
    }
}
