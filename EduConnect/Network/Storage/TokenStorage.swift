//
//  ECTokenStorage.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

protocol TokenStorageProtocol {
    var token: String? { get }
    func save(token: String)
    func clear()
}

final class TokenStorage: TokenStorageProtocol {
    
    private let keychain: KeychainServiceProtocol
    private let tokenKey = "auth_token"
    
    init(keychain: KeychainServiceProtocol = KeychainService()) {
        self.keychain = keychain
    }
    
    var token: String? {
        guard let data = keychain.load(forKey: tokenKey) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    func save(token: String) {
        guard let data = token.data(using: .utf8) else { return }
        keychain.save(data, forKey: tokenKey)
    }
    
    func clear() {
        keychain.delete(forKey: tokenKey)
    }
}
