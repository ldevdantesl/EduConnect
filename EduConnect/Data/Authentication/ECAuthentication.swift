//
//  ECAuthentication.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 14.01.2026.
//

import Foundation

protocol AuthenticationProtocol: AnyObject {
    var isLoggedIn: Bool { get }
    
    func sendVerificationCode(email: String?) async throws
    func verifyCode(email: String, code: String?) async throws
    func register(email: String, password: String?, passwordConfirmation: String?) async throws -> AuthUser
    func logIn(email: String?, password: String?) async throws -> AuthUser
    func me() async throws -> AuthUser
    func logOut() async throws
}


final class ECAuthentication: AuthenticationProtocol {
    private let networkService: NetworkServiceProtocol
    private let tokenStorage: TokenStorageProtocol
    
    init(networkService: NetworkServiceProtocol, tokenStorage: TokenStorageProtocol) {
        self.networkService = networkService
        self.tokenStorage = tokenStorage
    }
    
    var isLoggedIn: Bool {
        tokenStorage.token != nil
    }
    
    func sendVerificationCode(email: String?) async throws {
        try await networkService.authentication.sendCode(email: email)
    }
    
    func verifyCode(email: String, code: String?) async throws  {
        try await networkService.authentication.verifyCode(email: email, code: code)
    }
    
    func register(email: String, password: String?, passwordConfirmation: String?) async throws -> AuthUser {
        let response: AuthUserAndTokenData = try await networkService.authentication.register(email: email, password: password, confirmPassword: passwordConfirmation)
        if let token = response.token { tokenStorage.save(token: token) }
        return response.user
    }
    
    func logIn(email: String?, password: String?) async throws -> AuthUser {
        let response: AuthUserAndTokenData = try await networkService.authentication.login(email: email, password: password)
        if let token = response.token { tokenStorage.save(token: token) }
        return response.user
    }
    
    func logOut() async throws {
        try await networkService.authentication.logOut()
        tokenStorage.clear()
    }
    
    func me() async throws -> AuthUser {
        let response: AuthUserAndTokenData = try await networkService.authentication.me()
        return response.user
    }
}
