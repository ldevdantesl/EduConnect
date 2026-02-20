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
    case logout
    case none
    
    var title: String {
        switch self {
        case .universities: return ConstantLocalizedStrings.Sidebar.universities
        case .programs:     return ConstantLocalizedStrings.Sidebar.programs
        case .professions:  return ConstantLocalizedStrings.Sidebar.professions
        case .main:         return ConstantLocalizedStrings.Sidebar.main
        case .logout:       return ConstantLocalizedStrings.Sidebar.logOut
        case .none:         return ""
        }
    }
}
