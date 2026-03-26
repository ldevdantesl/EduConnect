//
//  ForgotPasswordScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit

protocol ForgotPasswordScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class ForgotPasswordScreenPresenter {
    
    // MARK: - VIPER
    weak var view: ForgotPasswordScreenViewProtocol?
    var router: ForgotPasswordScreenRouterProtocol
    var interactor: ForgotPasswordScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol

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
        } didTapEmail: { [weak self] _ in
            self?.view?.removeKeyboard()
            self?.view?.scrollToNextItem()
        }
        items.append(.typeInEmailItem(.init(id: "type-email", viewModel: typeEmailVM)))
        
        let newPasswordVM = ForgotPasswordNewPasswordCellViewModel { [weak self] password, confirmPass in
            print(password ?? "No password", confirmPass ?? "No confirm Password")
            self?.view?.removeKeyboard()
            self?.view?.scrollToNextItem()
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
}
