//
//  AuthUser.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.02.2026.
//

import Foundation

struct AuthUser: Decodable {
    let id: Int
    let name: String
    let surname: String?
    let patronymic: String?
    let email: String
    let phone: String?
    let isActive: Bool
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name, surname, patronymic, email, phone
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
