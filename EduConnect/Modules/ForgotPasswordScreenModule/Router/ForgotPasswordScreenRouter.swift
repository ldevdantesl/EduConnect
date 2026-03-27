//
//  ForgotPasswordScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

protocol ForgotPasswordScreenRouterProtocol {
    func goBack()
}

final class ForgotPasswordScreenRouter: ForgotPasswordScreenRouterProtocol {
    weak var viewController: ForgotPasswordScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func goBack() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
