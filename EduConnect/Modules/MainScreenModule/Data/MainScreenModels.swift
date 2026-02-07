//
//  MainScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit

enum MainScreenSection: Hashable {
    case header
    case careers
    case programs
    case academic
    case services
    case journal
    case footer
}

enum MainScreenItem: Hashable {
    case headerItem(DiffableItem<MainScreenHeaderCellViewModel>)
    case careersItem(DiffableItem<MainScreenCareersCellViewModel>)
    case programItem(DiffableItem<MainScreenProgramsCellViewModel>)
    case universitiesItem
    case academicUniversity(DiffableItem<UniversityCellViewModel>)
    case academicProfession(DiffableItem<CardWithImageCellViewModel>)
    case academicProgram(DiffableItem<CardWithImageCellViewModel>)
    case academicItem(DiffableItem<MainScreenAcademicCellViewModel>)
    case servicesItem
    case journalItem
    case footerItem
}
