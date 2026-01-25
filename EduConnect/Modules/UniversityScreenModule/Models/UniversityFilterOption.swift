//
//  UniversityFilterOption.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import Foundation

enum UniversityFilterOption: CaseIterable {
    case subjects
    case specializations
    case areas
    case military
    case stateOwned
    case dormitory
    case sorting
    case price
    
    var title: String {
        switch self {
        case .subjects: return "Предметы ЕНТ"
        case .specializations: return "Специализации вузов"
        case .areas: return "Области обучения"
        case .military: return "Военная кафедра"
        case .stateOwned: return "Государственный или нет"
        case .dormitory: return "Общежитие"
        case .sorting: return "Сортировка"
        case .price: return "Стоимость обучения"
        }
    }
    
    var isSlider: Bool {
        self == .price
    }
}
