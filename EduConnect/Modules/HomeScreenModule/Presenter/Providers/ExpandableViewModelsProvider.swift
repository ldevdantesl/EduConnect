//
//  ExpandableViewModelsProvider.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026
//

import Foundation

// MARK: - Protocol
public protocol ExpandableCellViewModel: CellViewModelProtocol, AnyObject {
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

struct ExpandableActions {
    var didTapSavePersonalInfo: ((String?, String?, String?) -> Void)?
    var didTapSaveFamilyInfo: ((String?, String?) -> Void)?
    var didTapSaveEducation: ((String?, String?, String?) -> Void)?
    
    var didTapAddActivity: (() -> Void)?
    var didTapAddOlympiad: (() -> Void)?
}

// MARK: - Provider Protocol

protocol ExpandableViewModelsProviderProtocol {
    func makeExpandableItem(for id: ExpandableCellID) -> HomeItem?
    func toggleExpandableCell(id: ExpandableCellID) -> HomeItem?
}

final class ExpandableViewModelsProvider: ExpandableViewModelsProviderProtocol {
    
    private var expandableViewModels: [ExpandableCellID: ExpandableCellViewModel] = [:]
    private var actions: ExpandableActions
    var onCellToggled: ((HomeItem) -> Void)?
    
    // MARK: - Init
    init(actions: ExpandableActions) {
        self.actions = actions
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
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: { [weak self] in self?.actions.didTapSavePersonalInfo?($0, $1, $2)}
            )
        case .familyInfo:
            return HomeScreenExpandableFamilyInfoCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: { [weak self] in self?.actions.didTapSaveFamilyInfo?($0, $1)}
            )
            
        case .education:
            return HomeScreenExpandableEducationCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: {[weak self] in self?.actions.didTapSaveEducation?($0, $1, $2)}
            )
            
        case .ENT:
            return HomeScreenExpandableENTCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) }
            )
            
        case .extracurricular:
            return HomeScreenExpandableExtracurricularCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id)},
                didTapAddActivity: { [weak self] in self?.actions.didTapAddActivity?() }
            )
            
        case .olympiads:
            return HomeScreenExpandableOlympiadCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id)}
            )
        }
    }
}

