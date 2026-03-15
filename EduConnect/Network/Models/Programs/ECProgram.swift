//
//  ECProgram.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

struct ECProgram: Identifiable, Decodable {
    
    struct University: Decodable {
        let id: Int
        let name: ECLocalizedString
        let logoURL: String

        enum CodingKeys: String, CodingKey {
            case id, name
            case logoURL = "logo_url"
        }
    }
    
    struct Profession: Identifiable, Decodable {
        let id: Int
        let name: ECLocalizedString
        let imageURL: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageURL = "image_url"
        }
    }
    
    let id: Int
    let universityID: Int
    let university: University
    let programCategoryID: Int
    let programCategory: ECProgramCategory
    let name: ECLocalizedString
    let type: Int
    let typeName: String
    let studyType: Int?
    let studyTypeName, price: String
    let totalPlaces, budgetPlaces, paidPlaces, occupiedPlaces: Int
    let freePlaces: Int
    let occupancyPercentage: Double
    let professions: [Profession]
    let isActive: Bool
    let sortOrder: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case universityID = "university_id"
        case university
        case programCategoryID = "program_category_id"
        case programCategory = "program_category"
        case name, type
        case typeName = "type_name"
        case studyType = "study_type"
        case studyTypeName = "study_type_name"
        case price
        case totalPlaces = "total_places"
        case budgetPlaces = "budget_places"
        case paidPlaces = "paid_places"
        case occupiedPlaces = "occupied_places"
        case freePlaces = "free_places"
        case occupancyPercentage = "occupancy_percentage"
        case professions
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
