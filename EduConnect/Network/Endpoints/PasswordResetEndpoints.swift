//
//  PasswordResetEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit

enum PasswordResetEndpoints: Endpoint {
    case requestCode(email: String?)
    case confirmNewPassword(email: String?, code: String?, newPassword: String?, newPasswordConfirm: String?)
    
    var path: String {
        switch self {
        case .requestCode: return "/password-reset/request-code"
        case .confirmNewPassword: return "/password-reset/confirm"
        }
    }
    
    var method: HTTPMethod { .post }
    
    var body: Data? {
        switch self {
        case .requestCode(let email):
            let json = ["email": email]
            return try? JSONEncoder().encode(json)
        case .confirmNewPassword(let email, let code, let newPassword, let newPasswordConfirm):
            let json = [
                "email" : email,
                "code": code,
                "password": newPassword,
                "password_confirmation": newPasswordConfirm
            ]
            return try? JSONEncoder().encode(json)
        }
    }
    
}
