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
    case related
}

enum ArticleDetailsItem: Hashable {
    case headerItem(DiffableItem<ArticleDetailsHeaderCellViewModel>)
    case universityItem(DiffableItem<ArticleDetailsUniversityCardCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
    case sectionHeaderItem(DiffableItem<SectionHeaderCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
    case plainTextItem(DiffableItem<PlainTextCellViewModel>)
}
