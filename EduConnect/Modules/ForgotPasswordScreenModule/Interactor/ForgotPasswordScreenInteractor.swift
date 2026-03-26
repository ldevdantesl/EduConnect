//
//  ForgotPasswordScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

protocol ForgotPasswordScreenInteractorProtocol: AnyObject {
}

final class ForgotPasswordScreenInteractor: ForgotPasswordScreenInteractorProtocol {
    weak var presenter: ForgotPasswordScreenPresenterProtocol?
    private let authService: AuthenticationProtocol
    
    init(authService: AuthenticationProtocol) {
        self.authService = authService
    }
}
