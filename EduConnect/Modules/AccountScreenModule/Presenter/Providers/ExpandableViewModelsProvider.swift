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
    var didTapSaveEntYear: ((Int) -> Void)?
    
    var didTapAddActivity: (() -> Void)?
    var didTapAddOlympiad: (() -> Void)?
    var didTapAddENTSubject: (() -> Void)?
    var didTapDeleteENTSubject: ((ProfileETH.Subject) -> Void)?
}

// MARK: - Provider Protocol
protocol ExpandableViewModelsProviderProtocol {
    func makeExpandableItem(for id: ExpandableCellID) -> AccountScreenItem?
    func toggleExpandableCell(id: ExpandableCellID) -> AccountScreenItem?
}

final class ExpandableViewModelsProvider: ExpandableViewModelsProviderProtocol {
    
    private var expandableViewModels: [ExpandableCellID: ExpandableCellViewModel] = [:]
    var onCellToggled: ((AccountScreenItem) -> Void)?
    
    // MARK: - Public Methods
    func makeExpandableItem(for id: ExpandableCellID) -> AccountScreenItem? {
        guard let vm = expandableViewModels[id] else { return nil }
        return .expandableCell(
            DiffableItem(id: id.rawValue, viewModel: vm)
        )
    }
    
    func configure(profile: Profile, actions: ExpandableActions) {
        let previousStates = expandableViewModels.mapValues { $0.isExpanded }
        
        ExpandableCellID.allCases.forEach {
            expandableViewModels[$0] = makeExpandableVM(id: $0, profile: profile, actions: actions, isExpanded: previousStates[$0] ?? false)
        }
    }
    
    @discardableResult
    func toggleExpandableCell(id: ExpandableCellID) -> AccountScreenItem? {
        guard let vm = expandableViewModels[id] else { return nil }
        vm.isExpanded.toggle()
        
        guard let item = makeExpandableItem(for: id) else { return nil }
        onCellToggled?(item)
        return item
    }
    
    // MARK: - Private Methods
    private func makeExpandableVM(
        id: ExpandableCellID,
        profile: Profile,
        actions: ExpandableActions,
        isExpanded: Bool
    ) -> ExpandableCellViewModel {
        switch id {
        case .personalInfo:
            return AccountScreenExpandablePersonalInfoCellViewModel(
                profile: profile,
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: { actions.didTapSavePersonalInfo?($0, $1, $2) }
            )
        case .familyInfo:
            return AccountScreenExpandableFamilyInfoCellViewModel(
                profile: profile,
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: { actions.didTapSaveFamilyInfo?($0, $1) }
            )
            
        case .education:
            return AccountScreenExpandableEducationCellViewModel(
                profile: profile,
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapSave: { actions.didTapSaveEducation?($0, $1, $2) }
            )
            
        case .ENT:
            return AccountScreenExpandableENTCellViewModel(
                profile: profile,
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapAddNewSubject: { actions.didTapAddENTSubject?() },
                didSetNewENTYear: { actions.didTapSaveEntYear?($0) },
                didTapDeleteSubject: { actions.didTapDeleteENTSubject?($0) }
            )
            
        case .extracurricular:
            return AccountScreenExpandableExtracurricularCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapAddActivity: { actions.didTapAddActivity?() }
            )
            
        case .olympiads:
            return AccountScreenExpandableOlympiadCellViewModel(
                isExpanded: isExpanded,
                didTapExpand: { [weak self] in self?.toggleExpandableCell(id: id) },
                didTapAddOlympiad: { actions.didTapAddOlympiad?() }
            )
        }
    }
}

