//
//  ProfileETH.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ProfileETH: Decodable {
    struct Subject: Decodable {
        struct InnerSubject: Decodable {
            let id: Int
            let name: ECLocalizedString
            let isActive: Bool
            let sortOrder: Int
            let createdAt, updatedAt: String

            enum CodingKeys: String, CodingKey {
                case id, name
                case isActive = "is_active"
                case sortOrder = "sort_order"
                case createdAt = "created_at"
                case updatedAt = "updated_at"
            }
        }
        
        let id: Int
        let studentEthID: Int
        let subjectID: Int
        let score: Int?
        let createdAt: String
        let updatedAt: String
        let subject: InnerSubject

        enum CodingKeys: String, CodingKey {
            case id
            case studentEthID = "student_eth_id"
            case subjectID = "subject_id"
            case score
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case subject
        }
    }
    
    let id: Int
    let studentID: Int?
    let year: Int?
    let createdAt: String?
    let updatedAt: String?
    let subjects: [Subject]

    enum CodingKeys: String, CodingKey {
        case id
        case studentID = "student_id"
        case year
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case subjects
    }
}
