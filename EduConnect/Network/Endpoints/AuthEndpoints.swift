//
//  AuthEndpoint.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

enum AuthEndpoints: Endpoint {
    case sendCode(email: String?)
    case verifyCode(email: String, code: String?)
    case register(email: String, password: String?, passwordConfirmation: String?)
    case login(email: String?, password: String?)
    case logOut(token: String?)
    case me(token: String?)
    
    var path: String {
        switch self {
        case .sendCode: return "/send-verification-code"
        case .login: return "/login"
        case .verifyCode: return "/verify-code"
        case .register: return "/register"
        case .me: return "/me"
        case .logOut: return "/logout"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .me: return .get
        default: return .post
        }
    }
    
    var auth: EndpointAuth {
        switch self {
        case .logOut(let token): return .bearer(token: token)
        case .me(let token): return .bearer(token: token)
        default: return .none
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
            
        case .register(let email, let password, let passwordConfirmation):
            return [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password),
                URLQueryItem(name: "password_confirmation", value: passwordConfirmation)
            ]
        case .login(let email, let password):
            return [
                URLQueryItem(name: "email", value: email),
                URLQueryItem(name: "password", value: password)
            ]
            
        default: return .none
        }
    }
}
