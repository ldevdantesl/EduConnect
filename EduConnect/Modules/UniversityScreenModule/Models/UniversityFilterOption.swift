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
        case .city: return "Город"
        case .profession: return "Профессия"
        case .universityType: return "Тип вуза"
        case .military: return "Военная кафедра"
        case .dormitory: return "Общежитие"
        case .sorting: return "Сортировка"
        case .price: return "Цена"
        }
    }
    
    var noneTitle: String { return "Любой" }
    
    var isSlider: Bool { self == .price }
    
    var staticSubItems: [String]? {
        switch self {
        case .universityType:
            return [noneTitle] + ECUniversity.UniversityType.allCases.map { $0.title }

        case .military, .dormitory:
            return [noneTitle, "Есть", "Нет"]

        case .sorting:
            return [noneTitle] + UniversityFilters.UniversitySortOption.allCases.map { $0.title }

        default:
            return nil
        }
    }
    
    func selectedValue(from filters: UniversityFilters, cities: [ECCity], professions: [ECProfession]) -> String? {
        switch self {
        case .city:
            guard let firstID = filters.cityIDs.first,
                  let city = cities.first(where: { $0.id == firstID }) else { return nil }
            return city.name.ru
            
        case .profession:
            guard let id = filters.professionID,
                  let profession = professions.first(where: { $0.id == id }) else { return nil }
            return profession.name.ru
            
        case .universityType:
            return filters.universityType?.title
            
        case .military:
            return filters.hasMilitary.map { $0 ? "Есть" : "Нет" }
            
        case .dormitory:
            return filters.hasDormitory.map { $0 ? "Есть" : "Нет" }
            
        case .sorting:
            return filters.sorting == .default ? nil : filters.sorting.title
            
        case .price:
            return nil
        }
    }
    
    func applyValue(_ value: String, to filters: inout UniversityFilters, cities: [ECCity], professions: [ECProfession]) {
        switch self {
        case .city:
            if let city = cities.first(where: { $0.name.ru == value }) {
                filters.cityIDs = [city.id]
            }
        case .profession:
            if let profession = professions.first(where: { $0.name.ru == value }) {
                filters.professionID = profession.id
            }
        case .universityType:
            filters.universityType = (value == noneTitle) ? nil :
                ECUniversity.UniversityType.allCases.first { $0.title == value }

        case .military:
            filters.hasMilitary = (value == noneTitle) ? nil : (value == "Есть")

        case .dormitory:
            filters.hasDormitory = (value == noneTitle) ? nil : (value == "Есть")

        case .sorting:
            filters.sorting = (value == title) ? .default :
                UniversityFilters.UniversitySortOption.allCases.first { $0.title == value } ?? .default
        case .price:
            break
        }
    }
}
