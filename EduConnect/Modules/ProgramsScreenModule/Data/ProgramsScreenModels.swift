//
//  ProgramsScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 26.01.2026.
//

import Foundation

enum ProgramsScreenSection: Hashable {
    case header
    case programs
    case footer
}

enum ProgramsScreenItem: Hashable {
    case headerItem(DiffableItem<ProgramsScreenHeaderCellViewModel>)
    case footerItem(DiffableItem<TabsFooterCellViewModel>)
    case programItem(DiffableItem<ProgramsScreenProgramCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
}
