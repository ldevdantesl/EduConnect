//
//  ProgramDetailsModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.03.2026.
//

import Foundation

enum ProgramDetailsSection: Hashable {
    case header
    case body
    case professions
    case facutlies
    case related
    case relatedHeader
}

enum ProgramDetailsItem: Hashable {
    case headerItem(DiffableItem<ProgramDetailsHeaderCellViewModel>)
    case universityItem(DiffableItem<ProgramDetailsUniversityCardCellViewModel>)
    case aboutItem(DiffableItem<ProgramDetailsAboutCellViewModel>)
    case cardWithImageItem(DiffableItem<CardWithImageCellViewModel>)
    case programItem(DiffableItem<DashedProgramCellViewModel>)
    case sectionHeaderItem(DiffableItem<SectionHeaderCellViewModel>)
}
