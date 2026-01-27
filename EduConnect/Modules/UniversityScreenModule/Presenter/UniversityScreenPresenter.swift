//
//  UniversityScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import SnapKit

protocol UniversityScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAccount()
}

final class UniversityScreenPresenter {
    weak var view: UniversityScreenViewProtocol?
    var router: UniversityScreenRouterProtocol
    var interactor: UniversityScreenInteractorProtocol

    init(interactor: UniversityScreenInteractorProtocol, router: UniversityScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension UniversityScreenPresenter: UniversityScreenPresenterProtocol {
    func viewDidLoad() {
        var count = 0
        let headerVM = UniversityScreenHeaderCellViewModel()
        let filtersVM = UniversityScreenFilterCellViewModel(didTapFilters: { [weak self] in self?.router.presentFilterView() })
        let pageIndicatorVM = PageIndicatorCellViewModel(totalPages: 4, currentPage: 3)
        let bottomInfoVM = UniversityScreenBottomInfoCellViewModel()
        let universities: [ECUniversity] = [.sample, .sample, .sample]
        
        var universityItems: [UniversityScreenItem] = universities.map {
            let vm = UniversityCellViewModel(university: $0, horizontallySpaced: true)
            let item = DiffableItem(id: $0.id + count, viewModel: vm)
            count += 1
            return .universityItem(item)
        }
        
        universityItems.append(UniversityScreenItem.pageIndicatorItem(.init(id: "pageIndicator", viewModel: pageIndicatorVM)))
        
        view?.applySnapshot(
            sections: [.headerInfo, .universities, .bottomInfo],
            itemsBySection: [
                .headerInfo: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .filterItem(.init(id: "filter", viewModel: filtersVM))
                ],
                .universities : universityItems,
                .bottomInfo : [.bottomInfoItem(.init(id: "bottomInfo", viewModel: bottomInfoVM))]
            ]
        )
    }
    
    func didTapTabBar() {
        router.openSidebar()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
}
