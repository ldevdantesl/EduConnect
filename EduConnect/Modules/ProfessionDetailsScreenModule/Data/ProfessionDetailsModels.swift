//
//  ProfessionDetailsScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.02.2026.
//

import Foundation

enum ProfessionDetailsSection: Hashable {
    case header
    case programsAndUniversities
    case about
    case articles
    case chooseButtons
    case related
    case footer
}

enum ProfessionDetailsItem: Hashable {
    case headerItem(DiffableItem<ProfessionDetailsHeaderCellViewModel>)
    case underlineItem(DiffableItem<UnderlineButtonCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
}
