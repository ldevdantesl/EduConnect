//
//  ECProfessions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECReferenceProfession: Identifiable, Decodable {
    let id: Int
    let name: ECLocalizedString
    let description: ECLocalizedString
    let image: String?
    let mainImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case image
        case mainImage = "main_image"
    }
}
