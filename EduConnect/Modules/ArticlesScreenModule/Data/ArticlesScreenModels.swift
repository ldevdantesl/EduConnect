//
//  ArticlesScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import Foundation

enum ArticlesScreenSection: Hashable {
    case header
    case segmentedControl
    case news
}

enum ArticlesScreenItem: Hashable {
    case headerItem(DiffableItem<ArticlesScreenHeaderCellViewModel>)
    case pageIndicatorItem(DiffableItem<PageIndicatorCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
    case segmentedItem(DiffableItem<ArticlesScreenSegmentedCellViewModel>)
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
}
