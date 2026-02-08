//
//  ECNewsType.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import Foundation

struct ECNewsType: Identifiable, Decodable, Hashable {
    let id: Int
    let name: ECLocalizedString
    let isActive: Bool
    let sortOrder: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case isActive = "is_active"
        case sortOrder = "sort_order"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ECNewsType, rhs: ECNewsType) -> Bool {
        lhs.id == rhs.id
    }
}
