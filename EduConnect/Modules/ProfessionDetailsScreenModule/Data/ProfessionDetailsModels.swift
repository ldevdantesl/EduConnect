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
    case related
}

enum ProfessionDetailsItem: Hashable {
    case headerItem(DiffableItem<ProfessionDetailsHeaderCellViewModel>)
    case progsAndUnisItem(DiffableItem<ProfessionDetailsProgsAndUnisCellViewModel>)
    case aboutItem(DiffableItem<ProfessionDetailsAboutCellViewModel>)
    case underlineItem(DiffableItem<UnderlineButtonCellViewModel>)
    case sectionHeaderItem(DiffableItem<SectionHeaderCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
}
