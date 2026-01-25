//
//  UniversityScreenAssembler.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

final class UniversityScreenAssembler {
    static func assemble(sidebarService: SidebarServiceProtocol) -> UniversityScreenVC {
        let interactor = UniversityScreenInteractor()
        let router = UniversityScreenRouter(sidebarService: sidebarService)
        let presenter = UniversityScreenPresenter(interactor: interactor, router: router)
        let viewController = UniversityScreenVC()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
