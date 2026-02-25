//
//  LoginScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import Foundation

enum LoginScreenSection: Hashable {
    case main
}

enum LoginScreenItem: Hashable {
    case loginItem(DiffableItem<LoginScreenLoginCellViewModel>)
    case registrationItem(DiffableItem<LoginScreenRegistrationCellViewModel>)
    case confirmRegisterItem(DiffableItem<LoginScreenConfirmRegistrationCellVM>)
    case setPasswordItem(DiffableItem<LoginScreenSetPasswordCellViewModel>)
    case completeRegisterItem(DiffableItem<LoginScreenCompleteRegistrationCellVM>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
}
