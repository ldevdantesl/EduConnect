//
//  AccountDeletionEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.03.2026.
//

import Foundation

enum AccountDeletionEndpoints: Endpoint {
    case requestCode(email: String?)
    case confirmDeletion(email: String?, code: String?)
    
    var path: String {
        switch self {
        case .requestCode: return "/account-deletion/request-code"
        case .confirmDeletion: return "/account-deletion/confirm"
        }
    }
    
    var method: HTTPMethod { return .post }
    
    var body: Data? {
        switch self {
        case .requestCode(let email):
            let json = ["email": email]
            return try? JSONEncoder().encode(json)
            
        case .confirmDeletion(let email, let code):
            let json = ["email": email, "code": code]
            return try? JSONEncoder().encode(json)
        }
    }
}
