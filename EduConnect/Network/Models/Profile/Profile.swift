//
//  Profile.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct Profile: Decodable {
    
    struct File: Decodable {
        let id: Int
        let filePath: String
        let fileURL: String

        enum CodingKeys: String, CodingKey {
            case id
            case filePath = "file_path"
            case fileURL = "file_url"
        }
    }
    
    let id: Int
    let name: String
    let surname: String?
    let patronymic: String?
    let email: String?
    let phone: String?
    let isActive: Bool
    let createdAt: String
    let updatedAt: String
    let education: ProfileEducation?
    let eth: ProfileETH?
    let familyContacts: [ProfileFamilyContact]
    let olympiads: [ProfileOlympiad]
    let extracurricularActivities: [ProfileExtracurricular]

    enum CodingKeys: String, CodingKey {
        case id, name, surname, patronymic, email, phone
        case isActive = "is_active"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case education, eth
        case familyContacts = "family_contacts"
        case olympiads
        case extracurricularActivities = "extracurricular_activities"
    }
}
