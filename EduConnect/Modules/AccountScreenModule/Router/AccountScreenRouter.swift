//
//  HomeScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenRouterProtocol {
    func showPopUp(viewModel: PopUpViewModel)
    func showSidebar()
    func routeToMain()
    func routeToUniversityByID(id: Int)
}

final class AccountScreenRouter: AccountScreenRouterProtocol {
    weak var viewController: AccountScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func showPopUp(viewModel: any PopUpViewModel) {
        switch viewModel {
        case let vm as AddExtracurricularActivityPopUpViewModel:
            let view = AddExtracurricularActivityPopUpView(viewModel: vm)
            viewController?.showPopup(view)
        case let vm as AddENTSubjectPopUpViewModel:
            let view = AddENTSubjectPopUpView(viewModel: vm)
            viewController?.showPopup(view)
        case let vm as AddENTSubjectPopUpViewModel:
            let view = AddENTSubjectPopUpView(viewModel: vm)
            viewController?.showPopup(view)
        case let vm as AddFamilyMemberPopUpViewModel:
            let view = AddFamilyMemberPopUpView(viewModel: vm)
            viewController?.showPopup(view)
        default: break
        }
    }
    
    func showSidebar() {
        appRouter.openSidebar()
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func routeToUniversityByID(id: Int) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, universityID: id)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
