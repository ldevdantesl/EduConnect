//
//  UniversityEndpoint.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

enum UniversityEndpoints: Endpoint {
    case getUniversities(page: Int, search: String?, filters: UniversityFilters?)
    
    case getUniversity(id: Int)
    
    var path: String {
        switch self {
        case .getUniversities: return "/universities"
        case .getUniversity(let id): return "/university/\(id)"
        }
    }
    
    var method: HTTPMethod { .get }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getUniversities(let page, let search, let filters):
            var items: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(page)")
            ]

            if let search, !search.isEmpty {
                items.append(URLQueryItem(name: "search", value: search))
            }
            
            if let filters {
                items.append(contentsOf: filters.toQueryItems())
            }
            
            return items.isEmpty ? nil : items
        default: return nil
        }
    }
}
