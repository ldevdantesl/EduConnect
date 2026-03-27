//
//  ForgotPasswordScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

protocol ForgotPasswordScreenInteractorProtocol: AnyObject {
    func sendCode(email: String?)
    func resendCode(email: String?)
    func confirmNewPassword(email: String?, code: String?, newPassword: String?, newPasswordConfirmation: String?)
}

final class ForgotPasswordScreenInteractor: ForgotPasswordScreenInteractorProtocol {
    weak var presenter: ForgotPasswordScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func sendCode(email: String?) {
        Task {
            do {
                let response = try await networkService.passwordReset.requestCode(email: email)
                self.presenter?.didSendCode(message: response.message)
            } catch {
                self.presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func resendCode(email: String?) {
        Task {
            do {
                let response = try await networkService.passwordReset.requestCode(email: email)
                self.presenter?.didResendCode(message: response.message)
            } catch {
                self.presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func confirmNewPassword(email: String?, code: String?, newPassword: String?, newPasswordConfirmation: String?) {
        Task {
            do {
                let response = try await networkService.passwordReset.confirmNewPassword(email: email, code: code, newPassword: newPassword, newPasswordConfirm: newPasswordConfirmation)
                self.presenter?.didConfirmNewPassword(message: response.message)
            } catch {
                self.presenter?.didReceiveError(error: error)
            }
        }
    }
}
