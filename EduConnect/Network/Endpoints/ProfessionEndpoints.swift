//
//  ProfessionEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import Foundation

enum ProfessionEndpoints: Endpoint {
    case getProfessions(searchText: String?, sortOption: ProfessionSortOption?, page: Int)
    case getProfessionDetails(professionID: Int)
    case getRelatedForProfession(professionID: Int, limit: Int)
    case getUniversitiesForProfession(professionID: Int, itemsPerPage: Int)
    case getProgramsForProfession(professionID: Int, itemsPerPage: Int)
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getProfessions: return "/professions-list"
        case .getProfessionDetails(let professionID): return "/professions-list/\(professionID)"
        case .getRelatedForProfession(let professionID, _): return "/professions-list/\(professionID)/related"
        case .getUniversitiesForProfession(let professionID, _): return "/professions-list/\(professionID)/universities"
        case .getProgramsForProfession(let professionID, _): return "/professions-list/\(professionID)/programs"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getProfessions(let searchText, let sortOption, let page):
            var items: [URLQueryItem] = [.init(name: "page", value: page.description)]
            if let sortOption { items.append(.init(name: "sort", value: sortOption.queryTitle)) }
            guard let searchText else { return items }
            items.append(.init(name: "search", value: searchText))
            return items
        case .getRelatedForProfession(_, let limit):
            return [.init(name: "limit", value: limit.description)]
        case .getUniversitiesForProfession(_, let itemsPerPage):
            return [.init(name: "per_page", value: itemsPerPage.description)]
        case .getProgramsForProfession(_, let itemsPerPage):
            return [.init(name: "per_page", value: itemsPerPage.description)]
        default: return .none
        }
    }
}
