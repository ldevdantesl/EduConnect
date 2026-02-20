//
//  ProfileEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.02.2026.
//

import Foundation

enum ProfileEndpoints: Endpoint {
    // MARK: - PROFILE
    case getProfile
    
    case getEducation
    case updateEducation(institution: String?, finalClass: String?, score: Double?)
    
    case getETH
    case addETHSubjects(subjectID: Int, score: String)
    case updateETHYear(year: Int)
    case deleteETHSubject(subjectID: Int)
    
    case getFamilyMembers
    case addFamilyMember(familyMemberID: Int, fullName: String, phoneNumber: String)
    case deleteFamilyMember(familyMemberID: Int)
    
    case getOlympiads
    case addOlympiad(olympiadTypeID: Int, olympiadPlaceID: Int, year: String)
    case deleteOlympiad(olympiadID: Int)
    
    case getExtracurricular
    case addExtracurricular(activityID: Int, description: String?)
    case deleteExtracurricular(activityID: Int)
    
    case updatePersonal(surname: String?, name: String?, patronymic: String?, phoneNumber: String?)
    
    var method: HTTPMethod {
        switch self {
        case .getProfile, .getEducation, .getETH, .getFamilyMembers, .getOlympiads, .getExtracurricular: return .get
        case .updatePersonal, .updateEducation, .updateETHYear: return .put
        case .addETHSubjects, .addFamilyMember, .addOlympiad, .addExtracurricular: return .post
        case .deleteETHSubject, .deleteFamilyMember, .deleteOlympiad, .deleteExtracurricular: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .getProfile: return "/profile"
        case .updatePersonal: return "/profile/personal"
            
        case .getEducation: return "/profile/education"
        case .updateEducation: return "/profile/education"
            
        case .getETH: return "/profile/eth"
        case .updateETHYear: return "/profile/eth-year"
        case .addETHSubjects: return "/profile/eth-subjects"
        case .deleteETHSubject(let subjectID): return "/profile/eth-subjects/\(subjectID)"
            
        case .getFamilyMembers: return "/profile/family-contacts"
        case .addFamilyMember: return "/profile/family-contacts"
        case .deleteFamilyMember(let familyMemberID): return "/profile/family-contacts/\(familyMemberID)"
            
        case .getOlympiads: return "/profile/olympiads"
        case .addOlympiad: return "/profile/olympiads"
        case .deleteOlympiad(let olympiadID): return "/profile/olympiads/\(olympiadID)"
            
        case .getExtracurricular: return "/profile/extracurricular"
        case .addExtracurricular: return "/profile/extracurricular"
        case .deleteExtracurricular(let activityID): return "/profile/extracurricular/\(activityID)"
        }
    }
    
    var auth: EndpointAuth { .bearer }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .updatePersonal(let surname, let name, let patronymic, let phoneNumber):
            return [
                .init(name: "surname", value: surname),
                .init(name: "name", value: name),
                .init(name: "patronymic", value: patronymic),
                .init(name: "phone_number", value: phoneNumber)
            ]
        case .updateEducation(let institution, let finalClass, let score):
            return [
                .init(name: "educational_institution", value: institution),
                .init(name: "class", value: finalClass),
                .init(name: "average_score", value: score?.description)
            ]
        case .updateETHYear(let year):
            return [.init(name: "year", value: year.description)]
            
        case .addETHSubjects(let subjectID, let score):
            return [
                .init(name: "subject_id", value: subjectID.description),
                .init(name: "score", value: score)
            ]
            
        case .addFamilyMember(let familyMemberID, let fullName, let phoneNumber):
            return [
                .init(name: "family_member_id", value: familyMemberID.description),
                .init(name: "full_name", value: fullName),
                .init(name: "phone_number", value: phoneNumber)
            ]
            
        case .addOlympiad(let olympiadTypeID, let olympiadPlaceID, let year):
            return [
                .init(name: "olympiad_type_id", value: olympiadTypeID.description),
                .init(name: "olympiad_place_id", value: olympiadPlaceID.description),
                .init(name: "year", value: year)
            ]
            
        case .addExtracurricular(let activityID, let description):
            return [
                .init(name: "extracurricular_activity_id", value: activityID.description),
                .init(name: "description", value: description)
            ]
            
        default: return .none
        }
    }
}
