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
}

final class AccountScreenRouter: AccountScreenRouterProtocol {
    weak var viewController: AccountScreenVC?
    private let appRoter: AppRoutingProtocol
    private let sidebarService: SidebarServiceProtocol
    
    init(appRouter: AppRoutingProtocol, sidebarService: SidebarServiceProtocol) {
        self.appRoter = appRouter
        self.sidebarService = sidebarService
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
        sidebarService.open()
    }
}
