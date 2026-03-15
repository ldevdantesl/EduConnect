//
//  ProgramEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

enum ProgramEndpoints: Endpoint {
    case getProgramCategories
    case getProgramsOfCategory(categorieID: Int)
    case getAllPrograms
    case getProgramDetails(programID: Int)
    case getRelatedProgramsForProgramID(programID: Int, limit: Int?)
    
    var path: String {
        switch self {
        case .getProgramCategories: return "/program-categories"
        case .getProgramsOfCategory(let categorieID): return "/program-categories/\(categorieID)/programs"
        case .getAllPrograms: return "/programs"
        case .getProgramDetails(let programID): return "/programs/\(programID)"
        case .getRelatedProgramsForProgramID(let programID, _): return "/programs/\(programID)/related"
        }
    }
    
    var method: HTTPMethod { return .get }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getRelatedProgramsForProgramID(_, let limit):
            if let limit {
                return [URLQueryItem.init(name: "limit", value: "\(limit)")]
            } else { return .none }
        default: return .none
        }
    }
}
