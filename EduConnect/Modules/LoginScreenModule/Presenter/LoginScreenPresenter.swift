//
//  LoginScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

protocol LoginScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didReceiveError(erorr: any Error)
    func didSendCode(email: String?)
    func didResendCode(email: String?)
    func didVerifyCode()
    func didLogin(user: AuthUser)
    func didRegister(user: AuthUser)
}

final class LoginScreenPresenter {
    weak var view: LoginScreenViewProtocol?
    var router: LoginScreenRouterProtocol
    var interactor: LoginScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol
    private var email: String?
    private var user: AuthUser?
    
    init(interactor: LoginScreenInteractorProtocol, router: LoginScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func didPressLogin(email: String?, password: String?) {
        self.view?.removeKeyboard()
        self.view?.showLoading()
        interactor.login(email: email, password: password)
    }
    
    private func didTapSendCode(email: String?) {
        self.view?.removeKeyboard()
        self.view?.showLoading()
        interactor.sendVerificationCode(email: email)
    }
    
    private func didTapVerifyCode(code: String?) {
        self.view?.removeKeyboard()
        self.view?.showLoading()
        guard let email = email else { return }
        interactor.verifyCode(email: email, code: code)
    }
    
    private func didTapSavePassword(password: String?, confirmPassword: String?) {
        self.view?.removeKeyboard()
        self.view?.showLoading()
        guard let email = email else { return }
        interactor.register(email: email, password: password, confirmPassword: confirmPassword)
    }
}

extension LoginScreenPresenter: LoginScreenPresenterProtocol {
    func viewDidLoad() {
        var items: [LoginScreenItem] = []
        let loginVM = LoginScreenLoginCellViewModel { [weak self] in
            self?.didPressLogin(email: $0, password: $1)
        } didPressRegister: {
            self.view?.scrollToNextItem()
        } didPressForgotPassword: { [weak self] in
            self?.router.routeToForgotPassword()
        }
        items.append(.loginItem(.init(id: "login", viewModel: loginVM)))
        
        let registrationVM = LoginScreenRegistrationCellViewModel { [weak self] in
            self?.view?.removeKeyboard()
            self?.view?.scrollToPreviousItem()
        } didTapSendCode: { [weak self] in
            self?.didTapSendCode(email: $0)
        } didTapPhone: { [weak self] in
            self?.view?.showError(errorMessage: "Phone Registration is not available for now")
        }
        items.append(.registrationItem(.init(id: "registration", viewModel: registrationVM)))
        
        let confirmRegisterVM = LoginScreenConfirmRegistrationCellVM { [weak self] in
            self?.didTapVerifyCode(code: $0)
        } resendAction: { [weak self] in
            self?.view?.showLoading()
            self?.interactor.resendVerficationCode(email: self?.email)
        } backButtonAction: { [weak self] in
            self?.view?.removeKeyboard()
            self?.view?.scrollToPreviousItem()
        }

        items.append(.confirmRegisterItem(.init(id: "confirmRegistration", viewModel: confirmRegisterVM)))
        
        let setPasswordVM = LoginScreenSetPasswordCellViewModel { [weak self] in
            guard let self = self else { return }
            self.didTapSavePassword(password: $0, confirmPassword: $1)
        } backButtonAction: { [weak self] in
            guard let self = self else { return }
            self.view?.removeKeyboard()
            self.view?.scrollToPreviousItem()
        }
        items.append(.setPasswordItem(.init(id: "setPassword", viewModel: setPasswordVM)))
        
        let completeRegistration = LoginScreenCompleteRegistrationCellVM {
            self.router.routeToAccountScreen()
        } goToMainAction: { [weak self] in
            guard let self = self else { return }
            self.router.routeToMainScreen()
        }
        items.append(.completeRegisterItem(.init(id: "completeRegistration", viewModel: completeRegistration)))
        
        view?.applySnapshot(
            sections: [.main],
            itemsBySection: [
                .main: items
            ]
        )
    }
    
    func didReceiveError(erorr: any Error) {
        self.view?.hideLoading()
        let userError = errorService.handle(erorr)
        self.view?.showError(errorMessage: userError.message)
    }
    
    func didSendCode(email: String?) {
        self.email = email
        self.view?.hideLoading()
        self.view?.scrollToNextItem()
        self.view?.showMessage(message: "Code has been successfully sended")
    }
    
    func didVerifyCode() {
        self.view?.hideLoading()
        self.view?.scrollToNextItem()
    }
    
    func didRegister(user: AuthUser) {
        self.view?.hideLoading()
        self.view?.scrollToNextItem()
        self.user = user
    }
    
    func didResendCode(email: String?) {
        self.view?.hideLoading()
        self.view?.showMessage(message: "Code has been successfully sended")
    }
    
    func didLogin(user: AuthUser) {
        self.view?.hideLoading()
        self.router.routeToMainScreen()
        self.user = user
    }
}
