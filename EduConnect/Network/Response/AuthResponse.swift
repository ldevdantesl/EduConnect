//
//  AuthData.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

struct AuthData: Decodable {
    let user: ECUser
    let token: String
}

typealias AuthResponse = EduConnectDataResponse<AuthData> 
