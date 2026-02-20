//
//  AuthAPIService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

protocol AuthAPISubServiceProtocol {
    func login(email: String?, password: String?) async throws -> AuthUserAndTokenData
    
    @discardableResult
    func logOut(token: String?) async throws -> EduConnectResponse
    func me(token: String?) async throws -> AuthUserAndTokenData
    
    @discardableResult
    func sendCode(email: String?) async throws -> EduConnectResponse
    
    @discardableResult
    func verifyCode(email: String, code: String?) async throws -> EduConnectResponse
    
    func register(email: String, password: String?, confirmPassword: String?) async throws -> AuthUserAndTokenData
}

final class AuthAPISubService: AuthAPISubServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func sendCode(email: String?) async throws -> EduConnectResponse {
        try await httpClient.request(AuthEndpoints.sendCode(email: email))
    }
    
    @discardableResult
    func verifyCode(email: String, code: String?) async throws -> EduConnectResponse {
        try await httpClient.request(AuthEndpoints.verifyCode(email: email, code: code))
    }
    
    func register(email: String, password: String?, confirmPassword: String?) async throws -> AuthUserAndTokenData {
        let response: EduConnectDataResponse<AuthUserAndTokenData> = try await httpClient.request(
            AuthEndpoints.register(email: email, password: password, passwordConfirmation: confirmPassword)
        )
        return response.data
    }
    
    func login(email: String?, password: String?) async throws -> AuthUserAndTokenData {
        let response: EduConnectDataResponse<AuthUserAndTokenData> = try await httpClient.request(AuthEndpoints.login(email: email, password: password))
        return response.data
    }
    
    @discardableResult
    func logOut(token: String?) async throws -> EduConnectResponse {
        try await httpClient.request(AuthEndpoints.logOut(token: token))
    }
    
    func me(token: String?) async throws -> AuthUserAndTokenData {
        try await httpClient.request(AuthEndpoints.me(token: token))
    }
}
