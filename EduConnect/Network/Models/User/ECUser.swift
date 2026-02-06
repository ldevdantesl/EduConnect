//
//  ECUser.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

struct ECUser: Decodable {
    let id: Int
    let name: String
    let email: String
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
    let roles: [ECRole]
}

struct ECRole: Decodable {
    let id: Int
    let name: String
}
