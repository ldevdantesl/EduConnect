//
//  ECProfessions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECProfession: Decodable {
    let id: Int
    let name: ECLocalizedString
    let description: ECLocalizedString
    let image: String
    let imageURL: String
    let mainImage: String
    let mainImageURL: String
    let isActive: Bool
    let sortOrder: Int
    let universitiesCount: Int
    let programsCount: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, image
        case imageURL = "image_url"
        case mainImage = "main_image"
        case mainImageURL = "main_image_url"
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case universitiesCount = "universities_count"
        case programsCount = "programs_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
