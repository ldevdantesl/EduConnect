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
    case academicUniversity(DiffableItem<CardWithImageCellViewModel>)
    case academicProfession(DiffableItem<CardWithImageCellViewModel>)
    case academicProgram(DiffableItem<MainScreenAcademicProgramCellViewModel>)
    case academicItem(DiffableItem<MainScreenAcademicCellViewModel>)
    case academicShowAll(DiffableItem<MainScreenAcademicShowAllCellViewModel>)
    case servicesItem(DiffableItem<MainScreenServicesCellViewModel>)
    case journalItem
    case footerItem
}
