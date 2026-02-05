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
    case faculties
    case programs
    case professions
    case articles
}

enum UniversityInfoScreenItem: Hashable {
    case headerItem(DiffableItem<UniversityInfoScreenHeaderCellViewModel>)
    case averageENTScoreItem(DiffableItem<UniversityInfoScreenAverageEntCellViewModel>)
    case aboutItem(DiffableItem<UniversityInfoScreenAboutCellViewModel>)
    case contactsItem(DiffableItem<UniversityInfoScreenContactsCellViewModel>)
    case sectionHeaderItem(DiffableItem<SectionHeaderCellViewModel>)
}
