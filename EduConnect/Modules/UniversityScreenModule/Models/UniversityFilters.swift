//
//  UniversityFilter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import Foundation

struct UniversityFilters {
    
    enum UniversitySortOption: String, CaseIterable {
        case `default`
        case nameAsc
        case nameDesc
        case priceAsc
        case priceDesc

        var title: String {
            switch self {
            case .default: return "По умолчанию"
            case .nameAsc: return "По названию А-Я"
            case .nameDesc: return "По названию Я-А"
            case .priceAsc: return "По цене ↑"
            case .priceDesc: return "По цене ↓"
            }
        }
        
        var apiValue: String {
            switch self {
            case .default: return "default"
            case .nameAsc: return "name_asc"
            case .nameDesc: return "name_desc"
            case .priceAsc: return "price_asc"
            case .priceDesc: return "price_desc"
            }
        }

        static func from(_ value: String) -> UniversitySortOption {
            switch value {
            case "По названию А-Я": return .nameAsc
            case "По названию Я-А": return .nameDesc
            case "По цене ↑": return .priceAsc
            case "По цене ↓": return .priceDesc
            default: return .default
            }
        }
    }
    
    // MARK: - PROPERTIES
    var cityIDs: [Int]?
    var professionID: Int?
    var universityType: ECUniversity.UniversityType?
    var hasMilitary: Bool?
    var hasDormitory: Bool?
    var priceMin: Int?
    var priceMax: Int?
    var sorting: UniversitySortOption = .default
    
    // MARK: - COMPUTED PROPERTY
    var appliedCount: Int {
           var count = 0
           
           if let cityIDs, !cityIDs.isEmpty { count += 1 }
           if professionID != nil { count += 1 }
           if universityType != nil { count += 1 }
           if hasMilitary != nil { count += 1 }
           if hasDormitory != nil { count += 1 }
           if priceMin != nil || priceMax != nil { count += 1 }
           if sorting != .default { count += 1 }
           
           return count
       }
    
    var hasActiveFilters: Bool {
        appliedCount > 0
    }
    
    // MARK: - FUNC
    func toQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = []
        
        if let cityIDs, !cityIDs.isEmpty {
            for id in cityIDs {
                items.append(URLQueryItem(name: "cities[]", value: String(id)))
            }
        }
        
        if let professionID {
            items.append(URLQueryItem(name: "profession_id", value: professionID.description))
        }
        
        if let type = universityType {
            items.append(URLQueryItem(name: "university_type", value: type.rawValue))
        }
        
        if let hasMilitary {
            items.append(URLQueryItem(name: "has_military_department", value: hasMilitary ? "1" : "0"))
        }
        
        if let hasDormitory {
            items.append(URLQueryItem(name: "has_dormitory", value: hasDormitory ? "1" : "0"))
        }
        
        if let priceMin {
            items.append(URLQueryItem(name: "price_min", value: "\(priceMin)"))
        }
        
        if let priceMax {
            items.append(URLQueryItem(name: "price_max", value: "\(priceMax)"))
        }
        
        if sorting != .default {
            items.append(URLQueryItem(name: "sort", value: sorting.apiValue))
        }
        
        return items
    }
}
