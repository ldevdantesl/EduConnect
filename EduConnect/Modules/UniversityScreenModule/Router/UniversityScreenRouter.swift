//
//  UniversityScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

protocol UniversityScreenRouterProtocol {
    func openSidebar()
    func presentFilterView()
}

final class UniversityScreenRouter: UniversityScreenRouterProtocol {
    weak var viewController: UniversityScreenVC?
    private let sidebarService: SidebarServiceProtocol
    
    init(sidebarService: SidebarServiceProtocol) {
        self.sidebarService = sidebarService
    }
    
    func openSidebar() {
        sidebarService.open()
    }
    
    func presentFilterView() {
        let vm = UniversityScreenFilterModalControllerViewModel()
        let vc = UniversityScreenFilterModalController(viewModel: vm)
        vc.modalPresentationStyle = .pageSheet

        if let sheet = vc.sheetPresentationController {
            sheet.detents = [
                .custom { _ in SharedConstants.screenHeight * 0.65 },
                .custom { _ in SharedConstants.screenHeight * 0.85 }
            ]
            sheet.prefersGrabberVisible = true
        }
        viewController?.present(vc, animated: true)
    }
}
