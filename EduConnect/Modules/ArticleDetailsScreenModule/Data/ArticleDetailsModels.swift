//
//  ArticleDetailsModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.03.2026.
//

import Foundation

enum ArticleDetailsSection: Hashable {
    case header
    case body
    case footer
}

enum ArticleDetailsItem: Hashable {
    case headerItem(DiffableItem<ArticleDetailsHeaderCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
}
