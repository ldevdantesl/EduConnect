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
    private let sidebarService: SidebarServiceProtocol
    private let appRouter: AppRoutingProtocol
    private let networkService: NetworkServiceProtocol
    private let errorService: ErrorServiceProtocol
    
    init(sidebarService: SidebarServiceProtocol, appRouter: AppRoutingProtocol, networkService: NetworkServiceProtocol, errorService: ErrorServiceProtocol) {
        self.sidebarService = sidebarService
        self.appRouter = appRouter
        self.networkService = networkService
        self.errorService = errorService
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
    
    func routeToMain() {
        appRouter.routeToMain()
    }
    
    func routeToUniversityInfo(_ university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(sidebarService: sidebarService, appRouter: appRouter, networkService: networkService, errorService: errorService, university: university)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
