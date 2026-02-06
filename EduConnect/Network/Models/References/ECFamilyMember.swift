//
//  ECFamilyMembers.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECFamilyMember: Decodable {
    let id: Int
    let name: ECLocalizedString
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
