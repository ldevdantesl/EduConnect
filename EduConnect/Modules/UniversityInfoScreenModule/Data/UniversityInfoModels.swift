//
//  UniversityInfoModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import Foundation

enum UniversityInfoScreenSection: Hashable {
    case header
    case main
    case footer
}

enum UniversityInfoScreenItem: Hashable {
    case headerItem(DiffableItem<UniversityInfoScreenHeaderCellViewModel>)
    case averageENTScoreItem(DiffableItem<UniversityInfoScreenAverageEntCellViewModel>)
    case aboutItem(DiffableItem<UniversityInfoScreenAboutCellViewModel>)
    case footerItem
}
