//
//  ExpandableViewModelsProvider.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026
//

import Foundation

// MARK: - Protocol
protocol ExpandableCellViewModel: CellViewModelProtocol, AnyObject {
    var isExpanded: Bool { get set }
    var didTapExpand: (() -> Void)? { get }
}

// MARK: - Expandable Cell IDs

enum ExpandableCellID: String, CaseIterable {
    case personalInfo
    case familyInfo
    case education
    case ENT
    case extracurricular
    case olympiads
}

// MARK: - Provider Protocol

protocol ExpandableViewModelsProviderProtocol {
    func makeExpandableItem(for id: ExpandableCellID) -> HomeItem?
    func toggleExpandableCell(id: ExpandableCellID) -> HomeItem?
}

final class ExpandableViewModelsProvider: ExpandableViewModelsProviderProtocol {
    
    private var expandableViewModels: [ExpandableCellID: ExpandableCellViewModel] = [:]
    var onCellToggled: ((HomeItem) -> Void)?
    
    // MARK: - Init
    init() {
        setupViewModels()
    }
    
    // MARK: - Setup
    private func setupViewModels() {
        ExpandableCellID.allCases.forEach { id in
            expandableViewModels[id] = makeExpandableVM(
                id: id,
                isExpanded: id == .personalInfo
            )
        }
    }
    
    // MARK: - Public Methods
    func makeExpandableItem(for id: ExpandableCellID) -> HomeItem? {
        guard let vm = expandableViewModels[id] else { return nil }
        return .expandableCell(
            DiffableItem(id: id.rawValue, viewModel: vm)
        )
    }
    
    @discardableResult
    func toggleExpandableCell(id: ExpandableCellID) -> HomeItem? {
        guard let vm = expandableViewModels[id] else { return nil }
        vm.isExpanded.toggle()
        
        guard let item = makeExpandableItem(for: id) else { return nil }
        onCellToggled?(item)
        return item
    }
    
    // MARK: - Private Methods
    private func makeExpandableVM(
        id: ExpandableCellID,
        isExpanded: Bool
    ) -> ExpandableCellViewModel {
        switch id {
        case .personalInfo:
            return HomeScreenExpandablePersonalInfoCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in
                    guard let self = self else { return }
                    self.toggleExpandableCell(id: id)
                },
            )
        case .familyInfo:
            return HomeScreenExpandableFamilyInfoCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in
                    guard let self = self else { return }
                    self.toggleExpandableCell(id: id)
                }
            )
        default:
            return HomeScreenExpandablePersonalInfoCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in
                    guard let self = self else { return }
                    self.toggleExpandableCell(id: id)
                },
            )
        }
    }
}

