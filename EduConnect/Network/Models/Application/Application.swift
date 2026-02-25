//
//  Application.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct Application: Decodable, Identifiable {
    struct University: Decodable {
        struct City: Decodable {
            let id: Int
            let name: String
        }
        
        let id: Int
        let name: String
        let logoURL: String
        let city: City

        enum CodingKeys: String, CodingKey {
            case id, name
            case logoURL = "logo_url"
            case city
        }
    }
    
    let id: Int
    let university: University
    let surname: String
    let name: String
    let patronymic: String
    let phone: String
    let email: String
    let status: Int
    let statusName: String
    let submittedAt: String
    let reviewedAt: String?
    let acceptedAt: String?
    let rejectedAt: String?
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, university, surname, name, patronymic, phone, email, status
        case statusName = "status_name"
        case submittedAt = "submitted_at"
        case reviewedAt = "reviewed_at"
        case acceptedAt = "accepted_at"
        case rejectedAt = "rejected_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
