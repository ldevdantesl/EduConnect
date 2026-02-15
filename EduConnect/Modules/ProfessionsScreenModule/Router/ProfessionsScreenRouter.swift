//
//  ProfessionsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenRouterProtocol {
}

final class ProfessionsScreenRouter: ProfessionsScreenRouterProtocol {
    weak var viewController: ProfessionsScreenVC?
    
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
}
