//
//  ECProgramDetails.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

struct ECProgramDetails: Decodable {
    
    struct Faculty: Identifiable, Decodable {
        let id: Int
        let name: ECLocalizedString
        let code: String
        let imageURL: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case code
            case imageURL = "image_url"
        }
    }
    
    let id, universityID: Int
    let university: ECProgram.University
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
    let professions: [ECProgram.Profession]
    let faculties: [Faculty]
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
        case professions, faculties
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
