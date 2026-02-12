//
//  HomeSection.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import Foundation

enum AccountScreenSection: Hashable {
    case main
    case universities
    case application
}

enum AccountScreenItem: Hashable {
    case headerItem(DiffableItem<SectionHeaderCellViewModel>)
    case university(DiffableItem<UniversityCellViewModel>)
    case expandableCell(DiffableItem<any ExpandableCellViewModel>)
    case mainTabInfo(DiffableItem<AccountScreenMainTabInfoCellViewModel>)
}

enum AccountScreenTab: Int {
    case myUniversities
    case application
    case main
    
    var headerNames: String {
        switch self {
        case .myUniversities: "My Universities"
        case .application: "Application"
        case .main: "Welcome, User"
        }
    }
}

