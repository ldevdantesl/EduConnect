//
//  HomeScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenRouterProtocol {
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel)
    func showAddEntSubjectPopUp(viewModel: AddENTSubjectPopUpViewModel)
    func showAddNewOlympiadPopUp(viewModel: AddOlympiadPopUpViewModel)
    func showSidebar()
    func routeToMain()
    func routeToUniversityInfo(_ university: ECUniversity)
}

final class AccountScreenRouter: AccountScreenRouterProtocol {
    weak var viewController: AccountScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel) {
        let popUpView = AddExtracurricularActivityPopUpView(viewModel: viewModel)
        viewController?.showPopup(popUpView)
    }
    
    func showAddEntSubjectPopUp(viewModel: AddENTSubjectPopUpViewModel) {
        let popUpView = AddENTSubjectPopUpView(viewModel: viewModel)
        viewController?.showPopup(popUpView)
    }
    
    func showAddNewOlympiadPopUp(viewModel: AddOlympiadPopUpViewModel) {
        let popUpView = AddOlympiadPopUpView(viewModel: viewModel)
        viewController?.showPopup(popUpView)
    }
    
    func showSidebar() {
        appRouter.openSidebar()
    }
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func routeToUniversityInfo(_ university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, university: university)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
