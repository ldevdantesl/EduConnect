//
//  UniversityScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit

protocol UniversityScreenRouterProtocol {
    func openSidebar()
    func presentFilterView(
        currentFilters: UniversityFilters, cities: [ECCity],
        professions: [ECReferenceProfession], onApply: ((UniversityFilters) -> Void)?
    )
    func routeToUniversityInfo(_ university: ECUniversity)
    func routeToMain()
    func openAccount()
    func goBack()
}

final class UniversityScreenRouter: UniversityScreenRouterProtocol {
    weak var viewController: UniversityScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func presentFilterView(
        currentFilters: UniversityFilters, cities: [ECCity],
        professions: [ECReferenceProfession], onApply: ((UniversityFilters) -> Void)?
    ) {
        let vm = UniversityScreenFilterModalControllerViewModel(currentFilters: currentFilters, cities: cities, professions: professions)
        vm.onApplyFilters = onApply
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
    
    func openSidebar() {
        appRouter.openSidebar()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func routeToUniversityInfo(_ university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, university: university)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
