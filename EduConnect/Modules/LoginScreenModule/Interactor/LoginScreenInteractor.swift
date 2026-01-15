//
//  LoginScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

protocol LoginScreenInteractorProtocol: AnyObject {
    func logIn()
}

final class LoginScreenInteractor: LoginScreenInteractorProtocol {
    weak var presenter: LoginScreenPresenterProtocol?
    private let authState: ECAuthenticationProtocol
    
    init(authState: ECAuthenticationProtocol) {
        self.authState = authState
    }
    
    func logIn() {
        authState.logIn()
    }
}
