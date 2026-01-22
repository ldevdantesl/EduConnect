//
//  HomeScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    var selectedTab: HomeTab { get set }
    var headerMenuViewModel: HomeScreenSegmentedReusableMenuViewModel { get }
}

final class HomeScreenPresenter {
    
    // MARK: - VIPER
    weak var view: HomeScreenViewProtocol?
    var router: HomeScreenRouterProtocol
    var interactor: HomeScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    var selectedTab: HomeTab = .main
    
    // MARK: - LAZY PROPERTIES
    private lazy var expandableProvider: ExpandableViewModelsProvider = {
        let expandableActions = ExpandableActions(
            didTapAddActivity: { [weak self] in
                let vm = AddExtracurricularActivityPopUpViewModel(onClose: self?.clearPopupView, didAddNewActivity: nil)
                self?.router.showAddExtracurricularPopUp(viewModel: vm)
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
    var headerMenuViewModel: HomeScreenSegmentedReusableMenuViewModel {
        HomeScreenSegmentedReusableMenuViewModel(
            currentTab: selectedTab,
            didSelectTab: { [weak self] in self?.didSelectAnotherTab(newTab: $0) }
        )
    }
    
    // MARK: - LIFECYCLE
    init(interactor: HomeScreenInteractorProtocol, router: HomeScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - PRIVATE FUNC
    private func clearPopupView() {
        self.view?.popUpView = nil
    }
    
    private func didSelectAnotherTab(newTab: HomeTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab
        let snapshot = snapshotFactory.makeSnapshot(for: newTab)
        view?.applySnapshot(sections: snapshot.sections, itemsBySection: snapshot.itemsBySection)
    }
}

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    func viewDidLoad() {
        didSelectAnotherTab(newTab: .myUniversities)
    }
}
