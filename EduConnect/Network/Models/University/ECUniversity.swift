//
//  University.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit

struct ECUniversity: Identifiable, Codable {
    
    enum UniversityType: String, Codable, CaseIterable {
        case state, `private`
        
        var title: String {
            switch self {
            case .state: return "Государственный"
            case .private: return "Частный"
            }
        }
    }
    
    struct City: Codable {
        let id: Int
        let name: String
    }
    
    struct ImagedEntity: Codable {
        let id: Int
        let name: String
        let imageURL: String
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case imageURL = "image_url"
        }
    }
    
    struct Program: Codable {
        let id: Int
        let name, price: String
        let budgetPlaces, paidPlaces: Int
        let studyType: Int?
        let studyTypeName: String

        enum CodingKeys: String, CodingKey {
            case id, name, price
            case budgetPlaces = "budget_places"
            case paidPlaces = "paid_places"
            case studyType = "study_type"
            case studyTypeName = "study_type_name"
        }
    }
    
    struct EntScores: Codable {
        let year: Int
        let budgetScore: String
        let contractScore: String

        enum CodingKeys: String, CodingKey {
            case year
            case budgetScore = "budget_score"
            case contractScore = "contract_score"
        }
    }
    
    let id: Int
    let name: String
    let description: String
    let logoURL: String?
    let mainImageURL: String
    let youtubeURL: String?
    let phone: String
    let email: String
    let address: String
    let foundedYear: Int
    let hasDormitory: Bool
    let hasMilitaryDepartment: Bool
    let universityType: UniversityType
    let universityTypeName: String
    let isActive: Bool
    let sortOrder: Int
    let minContractPrice: String?
    let city: City
    let professions: [ImagedEntity]
    let faculties: [ImagedEntity]
    let programs: [Program]
    let programsCount: Int
    let facultiesCount: Int
    let budgetPlaces: Int
    let paidPlaces: Int
    let entScores: [EntScores]?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, phone, email, address, programs
        case logoURL = "logo_url"
        case mainImageURL = "main_image_url"
        case youtubeURL = "youtube_url"
        case foundedYear = "founded_year"
        case hasDormitory = "has_dormitory"
        case hasMilitaryDepartment = "has_military_department"
        case universityType = "university_type"
        case universityTypeName = "university_type_name"
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case minContractPrice = "min_contract_price"
        case city, professions, faculties
        case programsCount = "programs_count"
        case facultiesCount = "faculties_count"
        case budgetPlaces = "budget_places"
        case paidPlaces = "paid_places"
        case entScores = "ent_scores"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

extension ECUniversity {
    static let sample: ECUniversity = Bundle.main.decode("SampleUniversity.json")
}
