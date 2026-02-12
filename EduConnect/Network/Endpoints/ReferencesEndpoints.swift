//
//  ReferencesEndpoint.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

enum ReferencesEndpoints: Endpoint {
    case getCities
    case getFaculties
    case getProgramCategories
    case getProfessions
    case getFamilyMembers
    case getSpecialConditions
    case getOlympiadTypes
    case getOlympiadPlaces
    case getSubjects
    case getExtracurricularActivities
    
    var path: String {
        switch self {
        case .getCities: return "/references/cities"
        case .getFaculties: return "/references/faculties"
        case .getProgramCategories: return "/references/program-categories"
        case .getProfessions: return "/references/professions"
        case .getFamilyMembers: return "/references/family-members"
        case .getSpecialConditions: return "/references/special-conditions"
        case .getOlympiadTypes: return "/references/olympiad-types"
        case .getOlympiadPlaces: return "/references/olympiad-places"
        case .getSubjects: return "/references/subjects"
        case .getExtracurricularActivities: return "/references/extracurricular-activities"
        }
    }
    
    var method: HTTPMethod { return .get }
}
