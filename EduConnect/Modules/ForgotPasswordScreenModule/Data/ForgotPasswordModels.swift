//
//  ForgotPasswordModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import Foundation

enum ForgotPasswordSection: Hashable {
    case main
}

enum ForgotPasswordItem: Hashable {
    case typeInEmailItem(DiffableItem<ForgotPasswordTypeEmailCellViewModel>)
    case newPasswordItem(DiffableItem<ForgotPasswordNewPasswordCellViewModel>)
    case backToLoginItem(DiffableItem<ForgotPasswordBackToLoginCellViewModel>)
}
