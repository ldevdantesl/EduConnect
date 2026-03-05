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
    case headerWithSubtitleItem(DiffableItem<HeaderWithSubtitleCellViewModel>)
    case university(DiffableItem<ApplicationCellViewModel>)
    case expandableCell(DiffableItem<any ExpandableCellViewModel>)
    case pendingApplicationItem(DiffableItem<AccountPendingApplicationsCellViewModel>)
    case mainTabInfo(DiffableItem<AccountScreenMainTabInfoCellViewModel>)
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
}

enum AccountScreenTab: Int {
    case myUniversities
    case application
    case main
    
    var tabTitles: String {
        switch self {
        case .myUniversities: ConstantLocalizedStrings.Account.MyUniversityTab.title
        case .application: ConstantLocalizedStrings.Account.ApplicationTab.title
        case .main: ConstantLocalizedStrings.Account.MainTab.title
        }
    }
    
    var tabNames: String {
        switch self {
        case .myUniversities: ConstantLocalizedStrings.Account.MyUniversityTab.tab
        case .application: ConstantLocalizedStrings.Account.ApplicationTab.tab
        case .main: ConstantLocalizedStrings.Account.MainTab.tab
        }
    }
}

