//
//  UnivetsityScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

enum UniversityScreenSection: Hashable {
    case main
    case bottomInfo
}

enum UniversityScreenItem: Hashable {
    case headerItem(DiffableItem<UniversityScreenHeaderCellViewModel>)
    case filterItem
    case universityItem(DiffableItem<UniversityCell>)
    case pageIndicatorItem
    case infoItem
}
