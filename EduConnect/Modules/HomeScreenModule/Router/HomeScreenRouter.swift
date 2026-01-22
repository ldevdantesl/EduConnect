//
//  HomeScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenRouterProtocol {
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel)
    func showAddEntSubjectPopUp(viewModel: AddENTSubjectPopUpViewModel)
}

final class HomeScreenRouter: HomeScreenRouterProtocol {
    weak var viewController: HomeScreenVC?
    weak var appRoter: AppRoutingProtocol?
    
    init(appRouter: AppRoutingProtocol) {
        self.appRoter = appRouter
    }
    
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel) {
        let popUpView = AddExtracurricularActivityPopUpView(viewModel: viewModel)
        guard let view = viewController?.view else { return }
        popUpView.show(in: view)
        viewController?.popUpView = popUpView
    }
    
    func showAddEntSubjectPopUp(viewModel: AddENTSubjectPopUpViewModel) {
        let popUpView = AddENTSubjectPopUpView(viewModel: viewModel)
        guard let view = viewController?.view else { return }
        popUpView.show(in: view)
        viewController?.popUpView = popUpView
    }
}
