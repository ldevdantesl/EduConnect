//
//  ECNetworkService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

protocol NetworkServiceProtocol {
    func sendCode(email: String) async throws -> EduConnectResponse
    func verifyCode(email: String, code: String) async throws -> EduConnectResponse
    func register(email: String, password: String) async throws -> ECUser
}

final class ECNetworkService: NetworkServiceProtocol {
    
    private let httpClient: HTTPClientProtocol
    private let tokenStorage: TokenStorageProtocol
    
    init(httpClient: HTTPClientProtocol, tokenStorage: TokenStorageProtocol) {
        self.httpClient = httpClient
        self.tokenStorage = tokenStorage
    }
    
    func sendCode(email: String) async throws -> EduConnectResponse {
        try await httpClient.request(AuthEndpoint.sendCode(email: email))
    }
    
    func verifyCode(email: String, code: String) async throws -> EduConnectResponse {
        try await httpClient.request(AuthEndpoint.verifyCode(email: email, code: code))
    }
    
    func register(email: String, password: String) async throws -> ECUser {
        let response: AuthResponse = try await httpClient.request(
            AuthEndpoint.register(email: email, password: password)
        )
        
        guard let data = response.data else {
            throw APIError.noData
        }
        tokenStorage.save(token: data.token)
        
        return data.user
    }
}
