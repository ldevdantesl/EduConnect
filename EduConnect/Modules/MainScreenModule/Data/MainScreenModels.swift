//
//  MainScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit

enum MainScreenSection: Hashable {
    case header
    case programs
    case careers
    case services
    case journal
    case footer
}

enum MainScreenItem: Hashable {
    case headerItem(DiffableItem<MainScreenHeaderCellViewModel>)
    case programItem
    case universitiesItem
    case sectionHeaderItem
    case careersItem
    case servicesItem
    case journalItem
    case footerItem
}
