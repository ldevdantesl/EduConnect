//
//  AccountDeletionAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import Foundation

protocol AccountDeletionAPISubServiceProtocol {
    @discardableResult
    func requestCode(email: String?) async throws -> EduConnectResponse
    
    @discardableResult
    func confirmDeletion(email: String?, code: String?) async throws -> EduConnectResponse
}

final class AccountDeletionAPISubService: AccountDeletionAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func requestCode(email: String?) async throws -> EduConnectResponse {
        try await httpClient.request(AccountDeletionEndpoints.requestCode(email: email))
    }
    
    func confirmDeletion(email: String?, code: String?) async throws -> EduConnectResponse {
        try await httpClient.request(AccountDeletionEndpoints.confirmDeletion(email: email, code: code))
    }
}
