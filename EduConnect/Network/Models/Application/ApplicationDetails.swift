//
//  ApplicationDetails.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ApplicationDetails: Decodable {
    let id: Int
    let university: Application.University
    let surname, name, patronymic, phone: String
    let email: String
    let status: Int
    let statusName, submittedAt: String
    let reviewedAt, acceptedAt, rejectedAt: String?
    let createdAt, updatedAt: String
    let familyContacts: [FamilyContact]
    let education: Education
    let eth: ETH
    let extracurricularActivities: [ExtracurricularActivity]
    let olympiads: [Olympiad]

    enum CodingKeys: String, CodingKey {
        case id, university, surname, name, patronymic, phone, email, status
        case statusName = "status_name"
        case submittedAt = "submitted_at"
        case reviewedAt = "reviewed_at"
        case acceptedAt = "accepted_at"
        case rejectedAt = "rejected_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case familyContacts = "family_contacts"
        case education, eth
        case extracurricularActivities = "extracurricular_activities"
        case olympiads
    }
    
    struct Education: Decodable {
        let id, applicationID: Int
        let educationalInstitution, educationClass, averageScore, createdAt: String
        let updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case applicationID = "application_id"
            case educationalInstitution = "educational_institution"
            case educationClass = "class"
            case averageScore = "average_score"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

    // MARK: - Eth
    struct ETH: Decodable {
        let id, year: Int
        let subjects: [Subject]
        
        struct Subject: Decodable {
            let subjectID: Int
            let subjectName, score: String

            enum CodingKeys: String, CodingKey {
                case subjectID = "subject_id"
                case subjectName = "subject_name"
                case score
            }
        }
    }

    // MARK: - ExtracurricularActivity
    struct ExtracurricularActivity: Decodable {
        let id, applicationID, studentActivityID, extracurricularActivityID: Int
        let description, createdAt, updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case applicationID = "application_id"
            case studentActivityID = "student_activity_id"
            case extracurricularActivityID = "extracurricular_activity_id"
            case description
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

    // MARK: - FamilyContact
    struct FamilyContact: Decodable {
        let id, applicationID, familyMemberID: Int
        let fullName: String?
        let phoneNumber, createdAt, updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case applicationID = "application_id"
            case familyMemberID = "family_member_id"
            case fullName = "full_name"
            case phoneNumber = "phone_number"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

    // MARK: - Olympiad
    struct Olympiad: Decodable {
        let id, applicationID, studentOlympiadID, olympiadTypeID: Int
        let olympiadPlaceID: Int
        let year, createdAt, updatedAt: String

        enum CodingKeys: String, CodingKey {
            case id
            case applicationID = "application_id"
            case studentOlympiadID = "student_olympiad_id"
            case olympiadTypeID = "olympiad_type_id"
            case olympiadPlaceID = "olympiad_place_id"
            case year
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
}
