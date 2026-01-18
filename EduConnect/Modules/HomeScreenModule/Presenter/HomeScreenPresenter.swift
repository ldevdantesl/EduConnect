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
    
    // MARK: - Properties
    weak var view: HomeScreenViewProtocol?
    var router: HomeScreenRouterProtocol
    var interactor: HomeScreenInteractorProtocol
    var selectedTab: HomeTab = .main
    
    private let snapshotFactory: HomeScreenSnapshotFactoryProtocol
    private let expandableProvider: ExpandableViewModelsProvider
    
    var headerMenuViewModel: HomeScreenSegmentedReusableMenuViewModel {
        HomeScreenSegmentedReusableMenuViewModel(
            currentTab: selectedTab,
            didSelectTab: { [weak self] tab in
                self?.didSelectAnotherTab(newTab: tab)
            }
        )
    }
    
    init(
        interactor: HomeScreenInteractorProtocol,
        router: HomeScreenRouterProtocol,
        expandableProvider: ExpandableViewModelsProvider = ExpandableViewModelsProvider(),
        snapshotFactory: HomeScreenSnapshotFactoryProtocol? = nil
    ) {
        self.interactor = interactor
        self.router = router
        self.expandableProvider = expandableProvider
        self.snapshotFactory = snapshotFactory ?? HomeScreenSnapshotFactory(expandableProvider: expandableProvider)
        
        setupBindings()
    }
    
    // MARK: - Private Methods
    private func setupBindings() {
        expandableProvider.onCellToggled = { [weak self] item in
            self?.view?.reconfigureItems(items: [item])
        }
    }
    
    func didSelectAnotherTab(newTab: HomeTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab
        let snapshot = snapshotFactory.makeSnapshot(for: newTab)
        view?.applySnapshot(sections: snapshot.sections, itemsBySection: snapshot.itemsBySection)
    }
}

// MARK: - HomeScreenPresenterProtocol

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    func viewDidLoad() {
        didSelectAnotherTab(newTab: .myUniversities)
    }
}
