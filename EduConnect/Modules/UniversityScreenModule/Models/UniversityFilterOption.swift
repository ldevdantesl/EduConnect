//
//  UniversityFilterOption.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import Foundation

enum UniversityFilterOption: String, CaseIterable {
    case city
    case profession
    case universityType
    case military
    case dormitory
    case sorting
    case price
    
    var title: String {
        switch self {
        case .city: return ConstantLocalizedStrings.University.Filter.Words.city
        case .profession: return ConstantLocalizedStrings.University.Filter.Words.profession
        case .universityType: return ConstantLocalizedStrings.University.Filter.Words.typeOfUni
        case .military: return ConstantLocalizedStrings.University.Filter.Words.militaryDepartment
        case .dormitory: return ConstantLocalizedStrings.University.Filter.Words.dormitory
        case .sorting: return ConstantLocalizedStrings.University.Filter.Words.sort
        case .price: return ConstantLocalizedStrings.University.Filter.Words.price
        }
    }
    
    var noneTitle: String { return ConstantLocalizedStrings.Common.none }
    
    var isPrice: Bool { self == .price }
    
    var staticSubItems: [String]? {
        switch self {
        case .universityType:
            return [noneTitle] + ECUniversity.UniversityType.allCases.map { $0.title }

        case .military, .dormitory:
            return [noneTitle, ConstantLocalizedStrings.University.Filter.with, ConstantLocalizedStrings.University.Filter.without]

        case .sorting:
            return [noneTitle] + UniversityFilters.UniversitySortOption.allCases.map { $0.title }

        default:
            return nil
        }
    }
    
    func selectedValue(from filters: UniversityFilters, cities: [ECCity], professions: [ECReferenceProfession]) -> String? {
        switch self {
        case .city:
            guard let cityIDs = filters.cityIDs,
                  let firstID = cityIDs.first,
                  let city = cities.first(where: { $0.id == firstID }) else { return nil }
            return city.name.toCurrentLanguage()
            
        case .profession:
            guard let id = filters.professionID,
                  let profession = professions.first(where: { $0.id == id }) else { return nil }
            return profession.name.toCurrentLanguage()
            
        case .universityType:
            return filters.universityType?.title
            
        case .military:
            return filters.hasMilitary.map { $0 ? ConstantLocalizedStrings.University.Filter.with : ConstantLocalizedStrings.University.Filter.without }
            
        case .dormitory:
            return filters.hasDormitory.map {
                $0 ? ConstantLocalizedStrings.University.Filter.with :
                ConstantLocalizedStrings.University.Filter.without
            }
            
        case .sorting:
            return filters.sorting == .default ? nil : filters.sorting.title
            
        case .price:
            return nil
        }
    }
    
    func applyValue(_ value: String, to filters: inout UniversityFilters, cities: [ECCity], professions: [ECReferenceProfession]) {
        switch self {
        case .city:
            if let city = cities.first(where: { $0.name.toCurrentLanguage() == value }) {
                filters.cityIDs = [city.id]
            } else { filters.cityIDs = nil }
        case .profession:
            if let profession = professions.first(where: { $0.name.toCurrentLanguage() == value }) {
                filters.professionID = profession.id
            } else { filters.professionID = nil }
        case .universityType:
            filters.universityType = (value == noneTitle) ? nil :
                ECUniversity.UniversityType.allCases.first { $0.title == value }

        case .military:
            filters.hasMilitary = (value == noneTitle) ? nil : (value == ConstantLocalizedStrings.University.Filter.with)

        case .dormitory:
            filters.hasDormitory = (value == noneTitle) ? nil : (value == ConstantLocalizedStrings.University.Filter.with)

        case .sorting:
            filters.sorting = (value == title) ? .default :
                UniversityFilters.UniversitySortOption.allCases.first { $0.title == value } ?? .default
        case .price:
            break
        }
    }
}
