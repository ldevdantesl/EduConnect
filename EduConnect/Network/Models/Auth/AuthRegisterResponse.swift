//
//  AuthData.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

struct AuthUserAndTokenData: Decodable {
    let user: AuthUser
    let token: String?
}
