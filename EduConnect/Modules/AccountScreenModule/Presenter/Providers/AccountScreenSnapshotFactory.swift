//
//  HomeScreenSnapshotFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026.
//

import Foundation

typealias SnapshotResult = (
    sections: [AccountScreenSection],
    itemsBySection: [AccountScreenSection: [AccountScreenItem]]
)

protocol AccountScreenSnapshotFactoryProtocol {
    func makeSnapshot(for tab: AccountScreenTab) -> SnapshotResult
}

final class AccountScreenSnapshotFactory: AccountScreenSnapshotFactoryProtocol {
    
    private let expandableProvider: ExpandableViewModelsProvider
    
    init(expandableProvider: ExpandableViewModelsProvider) {
        self.expandableProvider = expandableProvider
    }
    
    // MARK: - PUBLIC
    public func makeSnapshot(for tab: AccountScreenTab) -> SnapshotResult {
        switch tab {
        case .myUniversities:
            return makeUniversitiesSnapshot(for: tab)
        case .application:
            return makeApplicationSnapshot(for: tab)
        case .main:
            return makeMainSnapshot(for: tab)
        }
    }
    
    // MARK: - Private Builders
    private func makeUniversitiesSnapshot(for tab: AccountScreenTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        let university = ECUniversity.sample
        let universityVM = UniversityCellViewModel(university: university)
        
        return (
            sections: [.universities],
            itemsBySection: [
                .universities: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .university(.init(id: university.id, viewModel: universityVM))
                ]
            ]
        )
    }
    
    private func makeApplicationSnapshot(for tab: AccountScreenTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        
        var items: [AccountScreenItem] = [
            .headerItem(.init(id: "header", viewModel: headerVM))
        ]
        
        let expandableCells: [ExpandableCellID] = [
            .personalInfo,
            .familyInfo,
            .education,
            .ENT,
            .extracurricular,
            .olympiads
        ]
        
        expandableCells.forEach { id in
            if let item = expandableProvider.makeExpandableItem(for: id) {
                items.append(item)
            }
        }
        
        return (
            sections: [.application],
            itemsBySection: [.application: items]
        )
    }
    
    private func makeMainSnapshot(for tab: AccountScreenTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        let homeInfoVM = AccountScreenMainTabInfoCellViewModel()
        return (
            sections: [.main],
            itemsBySection: [
                .main: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .mainTabInfo(.init(id: "info", viewModel: homeInfoVM))
                ]
            ]
        )
    }
    
    // MARK: - Helpers
    private func makeHeaderVM(for tab: AccountScreenTab) -> SectionHeaderCellViewModel {
        SectionHeaderCellViewModel(title: tab.headerNames, titleSize: 30)
    }
}
