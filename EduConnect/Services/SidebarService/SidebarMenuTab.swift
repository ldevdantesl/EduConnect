//
//  SidebarMenuItem.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

enum SidebarMenuTab: CaseIterable {
    case main
    case universities
    case programs
    case professions
    case none
    
    var title: String {
        switch self {
        case .universities: return ConstantLocalizedStrings.Sidebar.universities
        case .programs:     return ConstantLocalizedStrings.Sidebar.programs
        case .professions:  return ConstantLocalizedStrings.Sidebar.professions
        case .main:         return ConstantLocalizedStrings.Sidebar.main
        case .none:         return ""
        }
    }
}
