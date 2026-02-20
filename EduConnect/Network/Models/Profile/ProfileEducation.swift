//
//  ProfileEducation.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ProfileEducation: Decodable {
    let id: Int
    let studentID: Int?
    let educationalInstitution: String
    let educationClass: String
    let averageScore: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case studentID = "student_id"
        case educationalInstitution = "educational_institution"
        case educationClass = "class"
        case averageScore = "average_score"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
