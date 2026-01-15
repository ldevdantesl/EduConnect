//
//  HomeSection.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import Foundation

enum HomeSection: Hashable {
    case main
    case universities
    case application
}

enum HomeItem: Hashable {
    case headerItem(DiffableItem<SectionHeaderCellViewModel>)
    case university(DiffableItem<HomeScreenUniversityCellViewModel>)
    case application
    case banner
}
