//
//  ForgotPasswordScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

protocol ForgotPasswordScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSendCode(message: String?)
    func didResendCode(message: String?)
    func didConfirmNewPassword(message: String?)
    func didReceiveError(error: any Error)
}

final class ForgotPasswordScreenPresenter {
    
    // MARK: - VIPER
    weak var view: ForgotPasswordScreenViewProtocol?
    var router: ForgotPasswordScreenRouterProtocol
    var interactor: ForgotPasswordScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private var email: String?
    private var code: String?

    init(interactor: ForgotPasswordScreenInteractorProtocol, router: ForgotPasswordScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        var items: [ForgotPasswordItem] = []
        
        let typeEmailVM = ForgotPasswordTypeEmailCellViewModel { [weak self] in
            self?.view?.removeKeyboard()
            self?.router.goBack()
        } didTapEmail: { [weak self] email in
            self?.email = email
            self?.view?.showLoading()
            self?.interactor.sendCode(email: email)
            self?.view?.removeKeyboard()
        }
        items.append(.typeInEmailItem(.init(id: "type-email", viewModel: typeEmailVM)))
        
        let confirmCodeVM = ForgotPasswordConfirmCodeCellViewModel { [weak self] code in
            self?.code = code
            self?.view?.scrollToNextItem()
        } didPressResendCode: { [weak self] in
            self?.view?.showLoading()
            self?.interactor.resendCode(email: self?.email)
        } didPressBack: { [weak self] in
            self?.view?.scrollToPreviousItem()
        }
        
        items.append(.confirmCodeItem(.init(id: "confirm-code", viewModel: confirmCodeVM)))
        
        let newPasswordVM = ForgotPasswordNewPasswordCellViewModel { [weak self] password, confirmPass in
            self?.view?.showLoading()
            self?.interactor.confirmNewPassword(
                email: self?.email, code: self?.code,
                newPassword: password, newPasswordConfirmation: confirmPass
            )
            self?.view?.removeKeyboard()
        } didTapBack: { [weak self] in
            self?.view?.removeKeyboard()
            self?.view?.scrollToPreviousItem()
        }
        items.append(.newPasswordItem(.init(id: "new-password", viewModel: newPasswordVM)))
        
        let backToLoginVM = ForgotPasswordBackToLoginCellViewModel { [weak self] in
            self?.router.goBack()
        }
        items.append(.backToLoginItem(.init(id: "back-to-login", viewModel: backToLoginVM)))
        
        view?.applySnapshot(
            sections: [.main],
            itemsBySection: [.main : items]
        )
    }
}

extension ForgotPasswordScreenPresenter: ForgotPasswordScreenPresenterProtocol {
    func viewDidLoad() {
        applySnapshot()
    }
    
    func didSendCode(message: String?) {
        self.view?.hideLoading()
        self.view?.scrollToNextItem()
        if let message { self.view?.showMessage(message: message) }
    }
    
    func didResendCode(message: String?) {
        self.view?.hideLoading()
        if let message { self.view?.showMessage(message: message) }
    }
    
    func didConfirmNewPassword(message: String?) {
        self.view?.hideLoading()
        self.view?.scrollToNextItem()
        if let message { self.view?.showMessage(message: message) }
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(errorMessage: userError.message)
        self.view?.hideLoading()
    }
}
