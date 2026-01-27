//
//  ProgramsScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

final class ProgramsScreenAssembler {
    static func assemble(sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol) -> ProgramsScreenVC {
        let interactor = ProgramsScreenInteractor()
        let router = ProgramsScreenRouter(sidebarService: sidebarService, appRouter: appRouter)
        let presenter = ProgramsScreenPresenter(interactor: interactor, router: router)
        let viewController = ProgramsScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
