//
//  ProgramsByCategoryModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.03.2026.
//

import Foundation

enum ProgramsByCategorySection: Hashable {
    case header
    case body
    case footer
}

enum ProgramsByCategoryItem: Hashable {
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
    case headerItem(DiffableItem<ProgramsByCategoryHeaderCellViewModel>)
}
