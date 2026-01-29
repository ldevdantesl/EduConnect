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
    
    var isSlider: Bool {
        self == .price
    }
}
