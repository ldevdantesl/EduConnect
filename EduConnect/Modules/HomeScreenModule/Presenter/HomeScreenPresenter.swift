//
//  HomeScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol HomeScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    
    var selectedTab: HomeTabs { get set }
    var headerMenuViewModel: HomeScreenSegmentedReusableMenuViewModel { get }
}

final class HomeScreenPresenter {
    weak var view: HomeScreenViewProtocol?
    var router: HomeScreenRouterProtocol
    var interactor: HomeScreenInteractorProtocol
    var selectedTab: HomeTabs = .myUniversities
    var headerMenuViewModel: HomeScreenSegmentedReusableMenuViewModel {
        HomeScreenSegmentedReusableMenuViewModel(
            currentTab: selectedTab,
            didSelectTab: { [weak self] tab in
                self?.didSelectAnotherTab(newTab: tab)
            }
        )
    }

    init(interactor: HomeScreenInteractorProtocol, router: HomeScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func didSelectAnotherTab(newTab: HomeTabs) {
        guard selectedTab != newTab else { return }

        selectedTab = newTab
        view?.reloadHeader()
    }
    
}

extension HomeScreenPresenter: HomeScreenPresenterProtocol {
    func viewDidLoad() {
        self.selectedTab = .myUniversities
        let university = ECUniversity.sample
        let viewModel = HomeScreenUniversityCellViewModel(university: university)
        let headerVM = SectionHeaderCellViewModel(title: "My Universities", titleSize: 30)
        self.view?.applySnapshot(
            sections: [.universities],
            itemsBySection: [
                .universities : [
                    .headerItem(DiffableItem(id: "header", viewModel: headerVM)),
                    .university(DiffableItem(id: university.id, viewModel: viewModel)),
                    .university(DiffableItem(id: 1234, viewModel: viewModel))
                ]
            ]
        )
    }
}
