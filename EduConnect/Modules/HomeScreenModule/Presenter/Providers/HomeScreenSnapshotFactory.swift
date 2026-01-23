//
//  HomeScreenSnapshotFactory.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026.
//

import Foundation

typealias SnapshotResult = (
    sections: [HomeSection],
    itemsBySection: [HomeSection: [HomeItem]]
)

protocol HomeScreenSnapshotFactoryProtocol {
    func makeSnapshot(for tab: HomeTab) -> SnapshotResult
}

final class HomeScreenSnapshotFactory: HomeScreenSnapshotFactoryProtocol {
    
    private let expandableProvider: ExpandableViewModelsProvider
    
    init(expandableProvider: ExpandableViewModelsProvider) {
        self.expandableProvider = expandableProvider
    }
    
    // MARK: - PUBLIC
    public func makeSnapshot(for tab: HomeTab) -> SnapshotResult {
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
    private func makeUniversitiesSnapshot(for tab: HomeTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        let university = ECUniversity.sample
        let universityVM = HomeScreenUniversityCellViewModel(university: university)
        
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
    
    private func makeApplicationSnapshot(for tab: HomeTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        
        var items: [HomeItem] = [
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
    
    private func makeMainSnapshot(for tab: HomeTab) -> SnapshotResult {
        let headerVM = makeHeaderVM(for: tab)
        let homeInfoVM = HomeScreenMainTabInfoCellViewModel()
        return (
            sections: [.main],
            itemsBySection: [
                .main: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .mainScreenInfo(.init(id: "info", viewModel: homeInfoVM))
                ]
            ]
        )
    }
    
    // MARK: - Helpers
    
    private func makeHeaderVM(for tab: HomeTab) -> SectionHeaderCellViewModel {
        SectionHeaderCellViewModel(title: tab.headerNames, titleSize: 30)
    }
}
