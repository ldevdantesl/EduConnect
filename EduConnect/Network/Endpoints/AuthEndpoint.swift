//
//  AuthEndpoint.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

enum AuthEndpoint: Endpoint {
    case sendCode(email: String)
    case verifyCode(email: String, code: String)
    case register(email: String, password: String)
    
    var path: String {
        switch self {
        case .sendCode: return "/send-verification-code"
        case .verifyCode: return "/verify-code"
        case .register: return "/register"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .sendCode, .verifyCode: return .get
        case .register: return .post
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .sendCode(let email):
            return [URLQueryItem(name: "email", value: email)]
            
        case .verifyCode(let email, let code):
            return [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "code", value: code)
            ]
            
        case .register(let email, let password):
            return [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password),
                URLQueryItem(name: "password_confirmation", value: password)
            ]
        }
    }
}
