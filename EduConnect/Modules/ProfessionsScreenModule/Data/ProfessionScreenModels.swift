//
//  ProfessionScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.02.2026.
//

import Foundation

enum ProfessionScreenSection: Hashable {
    case header
    case search
    case main
    case footer
}

enum ProfessionScreenItem: Hashable {
    case headerItem(DiffableItem<ProfessionScreenHeaderCellViewModel>)
    case searchItem(DiffableItem<ProfessionScreenSearchCellViewModel>)
    case footerItem(DiffableItem<TabsFooterCellViewModel>)
    
    case pageIndicatorItem(DiffableItem<PageIndicatorCellViewModel>)
    case cardItem(DiffableItem<CardCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
}
