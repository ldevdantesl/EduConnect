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
    case tests
    case article
    case calendar
    case none
    
    var title: String {
        switch self {
        case .universities: return "Universities"
        case .programs:     return "Programs"
        case .professions:  return "Professions"
        case .tests:        return "Tests"
        case .article:      return "Articles"
        case .calendar:     return "Calendar"
        case .main:         return "Main"
        case .none:         return ""
        }
    }
}
