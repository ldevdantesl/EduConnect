//
//  UniversityFilter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import Foundation

struct UniversityFilters {
    var subjects: [String] = []
    var specializations: [String] = []
    var areas: [String] = []
    var hasMilitary: Bool? = nil
    var isStateOwned: Bool? = nil
    var hasDormitory: Bool? = nil
    var sorting: UniversitySortOption = .default
    var priceMin: CGFloat? = nil
    var priceMax: CGFloat? = nil
}

enum UniversitySortOption {
    case `default`
    case rating
    case nameAZ
    case nameZA
    
    var title: String {
        switch self {
        case .default: return "По умолчанию"
        case .rating: return "По рейтингу"
        case .nameAZ: return "По названию А-Я"
        case .nameZA: return "По названию Я-А"
        }
    }
    
    static func from(_ value: String) -> UniversitySortOption {
        switch value {
        case "По рейтингу": return .rating
        case "По названию А-Я": return .nameAZ
        case "По названию Я-А": return .nameZA
        default: return .default
        }
    }
}
