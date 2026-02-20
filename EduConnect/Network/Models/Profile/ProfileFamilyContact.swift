//
//  ProfileFamilyContact.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ProfileFamilyContact: Decodable {
    let id: Int
    let studentID: Int
    let familyMemberID: Int
    let fullName: String?
    let phoneNumber: String
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case studentID = "student_id"
        case familyMemberID = "family_member_id"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
