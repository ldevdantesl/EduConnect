//
//  ProfessionDetailsScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

protocol ProfessionDetailsScreenRouterProtocol {
    func openAccount()
    func routeToMain()
    func goBack()
    func routeToProfession(profession: ECProfession)
    func routeToUniversities(filteredProfession: ECProfession)
    func openSetENT(subjects: [ENTSubject])
}

final class ProfessionDetailsScreenRouter: ProfessionDetailsScreenRouterProtocol {
    weak var viewController: ProfessionDetailsScreenVC?
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
    
    func routeToProfession(profession: ECProfession) {
        let vc = ProfessionDetailsScreenAssembler.assemble(appRouter: appRouter, professionID: profession.id)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToUniversities(filteredProfession: ECProfession) {
        let filters = UniversityFilters(professionID: filteredProfession.id)
        let vc = UniversityScreenAssembler.assemble(appRouter: appRouter, filters: filters)
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openSetENT(subjects: [ENTSubject]) {
        let vm = ShowENTPopupViewModel(subjects: subjects, onClose: self.viewController?.dismissPopup)
        let popup = ShowENTPopupView(viewModel: vm)
        self.viewController?.showPopup(popup)
    }
}
