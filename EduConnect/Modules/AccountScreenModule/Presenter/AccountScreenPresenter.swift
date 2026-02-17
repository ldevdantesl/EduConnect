//
//  AccountScreenPresenter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapTabBar()
    func didTapAppLogo()
    var selectedTab: AccountScreenTab { get set }
    var headerMenuViewModel: AccountScreenSegmentedReusableMenuViewModel { get }
    
    func didReceiveENTSubjects(entSubjects: [ENTSubject])
    func didReceiveExtracurricularActivities(activities: [ECExtracurricularActivity])
    func didReceiveError(error: any Error)
}

final class AccountScreenPresenter {

    // MARK: - VIPER
    weak var view: AccountScreenViewProtocol?
    private let router: AccountScreenRouterProtocol
    private let interactor: AccountScreenInteractorProtocol
    private let errorService: ErrorServiceProtocol

    // MARK: - STATE
    var selectedTab: AccountScreenTab = .main
    
    // MARK: - PROPERTIES
    private let dispatchGroup = DispatchGroup()
    private(set) var extracurricularActivities: [ECExtracurricularActivity] = []
    private(set) var entSubjects: [ENTSubject] = []

    // MARK: - EXPANDABLE PROVIDER
    private lazy var expandableProvider: ExpandableViewModelsProvider = {
        let actions = ExpandableActions(
            didTapAddActivity: { [weak self] in
                guard let self else { return }
                let vm = AddExtracurricularActivityPopUpViewModel(
                    activities: self.extracurricularActivities,
                    onClose: self.view?.dismissPopup,
                    didAddNewActivity: nil
                )
                self.router.showAddExtracurricularPopUp(viewModel: vm)
            },
            didTapAddOlympiad: { [weak self] in
                guard let self else { return }
                let vm = AddOlympiadPopUpViewModel(
                    subjects: self.entSubjects,
                    onClose: self.view?.dismissPopup,
                    didAddNewOlympiad: nil
                )
                self.router.showAddNewOlympiadPopUp(viewModel: vm)
            },
            didTapAddENTSubject: { [weak self] in
                guard let self else { return }
                let vm = AddENTSubjectPopUpViewModel(
                    entSubjects: self.entSubjects,
                    onClose: self.view?.dismissPopup,
                    didAddNewSubject: nil
                )
                self.router.showAddEntSubjectPopUp(viewModel: vm)
            }
        )

        let provider = ExpandableViewModelsProvider(actions: actions)

        provider.onCellToggled = { [weak self] item in
            self?.view?.reconfigureItems(items: [item])
        }

        return provider
    }()

    // MARK: - HEADER MENU VM
    var headerMenuViewModel: AccountScreenSegmentedReusableMenuViewModel {
        AccountScreenSegmentedReusableMenuViewModel(
            currentTab: selectedTab,
            didSelectTab: { [weak self] in self?.didSelectAnotherTab(newTab: $0) }
        )
    }

    // MARK: - INIT
    init(
        interactor: AccountScreenInteractorProtocol,
        router: AccountScreenRouterProtocol,
        errorService: ErrorServiceProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }

    // MARK: - SNAPSHOT DISPATCH
    private func didSelectAnotherTab(newTab: AccountScreenTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab

        switch newTab {
        case .myUniversities:
            showUniversities(tab: newTab)
        case .application:
            showApplication(tab: newTab)
        case .main:
            showMain(tab: newTab)
        }
    }

    // MARK: - SNAPSHOTS
    private func showUniversities(tab: AccountScreenTab) {
        let headerVM = makeHeaderVM(for: tab)
        let university = ECUniversity.sample
        let universityVM = UniversityCellViewModel(university: university) { [weak self] in
            self?.router.routeToUniversityInfo($0)
        }

        view?.applySnapshot(
            sections: [.universities],
            itemsBySection: [
                .universities: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .university(.init(id: university.id, viewModel: universityVM))
                ]
            ]
        )
    }

    private func showApplication(tab: AccountScreenTab) {
        let headerVM = makeHeaderVM(for: tab)

        var items: [AccountScreenItem] = [
            .headerItem(.init(id: "header", viewModel: headerVM))
        ]

        let expandableCells: [ExpandableCellID] = [
            .personalInfo, .familyInfo,
            .education, .ENT,
            .extracurricular, .olympiads
        ]

        expandableCells.forEach {
            if let item = expandableProvider.makeExpandableItem(for: $0) {
                items.append(item)
            }
        }

        view?.applySnapshot(
            sections: [.application],
            itemsBySection: [.application: items]
        )
    }

    private func showMain(tab: AccountScreenTab) {
        let headerVM = makeHeaderVM(for: tab)
        let infoVM = AccountScreenMainTabInfoCellViewModel()

        view?.applySnapshot(
            sections: [.main],
            itemsBySection: [
                .main: [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .mainTabInfo(.init(id: "info", viewModel: infoVM))
                ]
            ]
        )
    }

    // MARK: - HELPERS
    private func makeHeaderVM(for tab: AccountScreenTab) -> SectionHeaderCellViewModel {
        SectionHeaderCellViewModel(
            title: tab.tabTitles,
            titleSize: 30
        )
    }
}

// MARK: - PROTOCOL
extension AccountScreenPresenter: AccountScreenPresenterProtocol {
    func viewDidLoad() {
        self.view?.showLoading()
        
        dispatchGroup.enter()
        interactor.getEntSubjects()
        
        dispatchGroup.enter()
        interactor.getExtracurricularActivities()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.didSelectAnotherTab(newTab: .myUniversities)
        }
    }

    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didTapTabBar() {
        router.showSidebar()
    }
    
    func didReceiveENTSubjects(entSubjects: [ENTSubject]) {
        self.entSubjects = entSubjects
        dispatchGroup.leave()
    }
    
    func didReceiveExtracurricularActivities(activities: [ECExtracurricularActivity]) {
        self.extracurricularActivities = activities
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userFacingError = errorService.handle(error)
        self.view?.showError(error: userFacingError)
    }
}
