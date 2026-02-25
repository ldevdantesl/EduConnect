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
    case stepsItem(DiffableItem<MainScreenStepsCellViewModel>)
    case careersItem(DiffableItem<MainScreenCareersCellViewModel>)
    case programItem(DiffableItem<MainScreenProgramsCellViewModel>)
    
    case academicProgram(DiffableItem<MainScreenAcademicProgramCellViewModel>)
    case academicItem(DiffableItem<MainScreenAcademicCellViewModel>)
    case academicShowAll(DiffableItem<MainScreenAcademicShowAllCellViewModel>)
    
    case servicesItem(DiffableItem<MainScreenServicesCellViewModel>)
    case journalItem(DiffableItem<MainScreenJournalCellViewModel>)
    
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
    case underlineButtonItem(DiffableItem<UnderlineButtonCellViewModel>)
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
    
    case footerItem(DiffableItem<MainScreenFooterCellViewModel>)
}
