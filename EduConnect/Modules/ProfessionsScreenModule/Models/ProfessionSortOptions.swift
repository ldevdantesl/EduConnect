//
//  ProfessionSortOptions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import Foundation

enum ProfessionSortOption: CaseIterable {
    case fromAToZ
    case fromZToA
    
    var title: String {
        switch self {
        case .fromAToZ: return ConstantLocalizedStrings.Words.fromAtoZ
        case .fromZToA: return ConstantLocalizedStrings.Words.fromZtoA
        }
    }
    
    var queryTitle: String {
        switch self {
        case .fromAToZ: return "name_asc"
        case .fromZToA: return "name_desc"
        }
    }
}
