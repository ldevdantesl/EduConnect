//
//  LoginScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

protocol LoginScreenInteractorProtocol: AnyObject {
    func sendVerificationCode(email: String?)
    func verifyCode(email: String, code: String?)
    func register(email: String, password: String?, confirmPassword: String?)
}

final class LoginScreenInteractor: LoginScreenInteractorProtocol {
    weak var presenter: LoginScreenPresenterProtocol?
    private let authentication: AuthenticationProtocol
    
    init(authentication: AuthenticationProtocol) {
        self.authentication = authentication
    }
    
    func sendVerificationCode(email: String?) {
        Task {
            do {
                try await authentication.sendVerificationCode(email: email)
                presenter?.didSendCode(email: email)
            } catch {
                presenter?.didReceiveError(erorr: error)
            }
        }
    }
    
    func verifyCode(email: String, code: String?) {
        Task {
            do {
                try await authentication.verifyCode(email: email, code: code)
                presenter?.didVerifyCode()
            } catch {
                presenter?.didReceiveError(erorr: error)
            }
        }
    }
    
    func register(email: String, password: String?, confirmPassword: String?) {
        Task {
            do {
                let user = try await authentication.register(email: email, password: password, passwordConfirmation: confirmPassword)
                presenter?.didRegister(user: user)
            } catch {
                presenter?.didReceiveError(erorr: error)
            }
        }
    }
}
