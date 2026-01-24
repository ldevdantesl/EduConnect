//
//  UnivetsityScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

enum UniversityScreenSection: Hashable {
    case headerInfo
    case universities
    case bottomInfo
}

enum UniversityScreenItem: Hashable {
    case headerItem(DiffableItem<UniversityScreenHeaderCellViewModel>)
    case filterItem(DiffableItem<UniversityScreenFilterCellViewModel>)
    case universityItem(DiffableItem<UniversityCell>)
    case pageIndicatorItem
    case infoItem
}
