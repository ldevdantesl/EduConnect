//
//  ApplicationEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

enum ApplicationEndpoints: Endpoint {
    case getApplications
    case postApplication(universityID: Int)
    case applicationDetails(applicationID: Int)
    case deleteApplication(applicationID: Int)
    case getApplicationStatus(universityID: Int)
    
    var path: String {
        switch self {
        case .getApplications, .postApplication: return "/applications"
        case .applicationDetails(let applicationID), .deleteApplication(let applicationID): return "/applications/\(applicationID)"
        case .getApplicationStatus(let universityID): return "/applications/by-university/\(universityID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getApplications, .applicationDetails, .getApplicationStatus: return .get
        case .postApplication: return .post
        case .deleteApplication: return .delete
        }
    }
    
    var auth: EndpointAuth { return .bearer }
    
    var body: Data? {
        switch self {
        case .postApplication(let universityID): return try? JSONSerialization.data(withJSONObject: ["university_id" : universityID])
        default: return .none
        }
    }
}
