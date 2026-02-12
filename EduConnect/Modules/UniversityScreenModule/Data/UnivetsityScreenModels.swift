//
//  UnivetsityScreenModels.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

enum UniversityScreenSection: Hashable, CaseIterable {
    case header
    case universities
    case footer
}

enum UniversityScreenItem: Hashable {
    case headerItem(DiffableItem<UniversityScreenHeaderCellViewModel>)
    case filterItem(DiffableItem<UniversityScreenFilterCellViewModel>)
    case universityItem(DiffableItem<UniversityCellViewModel>)
    case pageIndicatorItem(DiffableItem<PageIndicatorCellViewModel>)
    case footerItem(DiffableItem<TabsFooterCellViewModel>)
    case loadingItem(DiffableItem<LoadingCellViewModel>)
}
