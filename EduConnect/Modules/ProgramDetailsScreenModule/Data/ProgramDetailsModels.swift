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
    case footer
}

enum ProgramDetailsItem: Hashable {
    case notFoundItem(DiffableItem<NotFoundCellViewModel>)
    
}
