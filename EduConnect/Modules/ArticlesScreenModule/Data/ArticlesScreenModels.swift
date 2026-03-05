//
//  ArticlesScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import Foundation

enum ArticlesScreenSection: Hashable {
    case header
    case all
    case news
    case calendar
    case footer
}

enum ArticlesScreenItem: Hashable {
    case headerItem(DiffableItem<ArticlesScreenHeaderCellViewModel>)
    case pageIndicatorItem(DiffableItem<PageIndicatorCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
}
