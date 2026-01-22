//
//  HomeScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenRouterProtocol {
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel)
}

final class HomeScreenRouter: HomeScreenRouterProtocol {
    weak var viewController: HomeScreenVC?
    weak var appRoter: AppRoutingProtocol?
    
    init(appRouter: AppRoutingProtocol) {
        self.appRoter = appRouter
    }
    
    func showAddExtracurricularPopUp(viewModel: AddExtracurricularActivityPopUpViewModel) {
        let popUpView = AddExtracurricularActivityPopUpView(viewModel: viewModel)
        guard let viewController = viewController else { return }
        popUpView.show(in: viewController.view)
        viewController.popUpView = popUpView
    }
}
