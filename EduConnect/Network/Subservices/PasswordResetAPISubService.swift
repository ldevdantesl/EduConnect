//
//  PasswordResetAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import UIKit

protocol PasswordResetAPISubServiceProtocol {
    func requestCode(email: String?) async throws -> EduConnectResponse
    func confirmNewPassword(email: String?, code: String?, newPassword: String?, newPasswordConfirm: String?) async throws -> EduConnectResponse
}

final class PasswordResetAPISubService: PasswordResetAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func requestCode(email: String?) async throws -> EduConnectResponse {
        try await httpClient.request(PasswordResetEndpoints.requestCode(email: email))
    }
    
    func confirmNewPassword(email: String?, code: String?, newPassword: String?, newPasswordConfirm: String?) async throws -> EduConnectResponse {
        try await httpClient.request(PasswordResetEndpoints.confirmNewPassword(email: email, code: code, newPassword: newPassword, newPasswordConfirm: newPasswordConfirm))
    }
}
