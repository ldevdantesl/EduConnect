//
//  HomeScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    var selectedTab: AccountScreenTab { get set }
    var headerMenuViewModel: AccountScreenSegmentedReusableMenuViewModel { get }
}

final class AccountScreenPresenter {
    
    // MARK: - VIPER
    weak var view: AccountScreenViewProtocol?
    var router: AccountScreenRouterProtocol
    var interactor: AccountScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    var selectedTab: AccountScreenTab = .main
    
    // MARK: - LAZY PROPERTIES
    private lazy var expandableProvider: ExpandableViewModelsProvider = {
        let expandableActions = ExpandableActions(
            didTapAddActivity: { [weak self] in
                let vm = AddExtracurricularActivityPopUpViewModel(onClose: self?.view?.dismissPopup, didAddNewActivity: nil)
                self?.router.showAddExtracurricularPopUp(viewModel: vm)
            },
            didTapAddOlympiad: { [weak self] in
                let vm = AddOlympiadPopUpViewModel(onClose: self?.view?.dismissPopup, didAddNewOlympiad: nil)
                self?.router.showAddNewOlympiadPopUp(viewModel: vm)
            },
            didTapAddENTSubject: { [weak self] in
                let vm = AddENTSubjectPopUpViewModel(onClose: self?.view?.dismissPopup, didAddNewSubject: nil)
                self?.router.showAddEntSubjectPopUp(viewModel: vm)
            }
        )
        
        let provider = ExpandableViewModelsProvider(actions: expandableActions)
        
        provider.onCellToggled = { [weak self] item in
            self?.view?.reconfigureItems(items: [item])
        }
        
        return provider
    }()
    
    private lazy var snapshotFactory: HomeScreenSnapshotFactoryProtocol = HomeScreenSnapshotFactory(expandableProvider: expandableProvider)
    
    // MARK: - COMPUTED PROPERTIES
    var headerMenuViewModel: AccountScreenSegmentedReusableMenuViewModel {
        AccountScreenSegmentedReusableMenuViewModel(
            currentTab: selectedTab,
            didSelectTab: { [weak self] in self?.didSelectAnotherTab(newTab: $0) }
        )
    }
    
    // MARK: - LIFECYCLE
    init(interactor: AccountScreenInteractorProtocol, router: AccountScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - PRIVATE FUNC
    private func didSelectAnotherTab(newTab: AccountScreenTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab
        let snapshot = snapshotFactory.makeSnapshot(for: newTab)
        view?.applySnapshot(sections: snapshot.sections, itemsBySection: snapshot.itemsBySection)
    }
}

extension AccountScreenPresenter: AccountScreenPresenterProtocol {
    func viewDidLoad() {
        didSelectAnotherTab(newTab: .myUniversities)
    }
    
    func didTapTabBar() {
        router.showSidebar()
    }
}
