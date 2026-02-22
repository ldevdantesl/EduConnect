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

    func didPerformTask(message: String?, refreshID: ExpandableCellID?)
    func didReceiveProfile(_ profile: Profile)
    func didReceiveProfileApplications(_ applications: [Application])
    func didReceiveENTSubjects(entSubjects: [ENTSubject])
    func didReceiveExtracurricularActivities(activities: [ECExtracurricularActivity])
    func didReceiveError(error: any Error)
    func didReceiveErrorInApplication(error: any Error, refreshID: ExpandableCellID?)
}

final class AccountScreenPresenter {
    // MARK: - VIPER
    weak var view: AccountScreenViewProtocol?
    private let router: AccountScreenRouterProtocol
    private let interactor: AccountScreenInteractorProtocol
    private let errorService: ErrorServiceProtocol
    private var refreshID: ExpandableCellID?

    // MARK: - STATE
    var selectedTab: AccountScreenTab = .main
    
    // MARK: - PROPERTIES
    private let dispatchGroup = DispatchGroup()
    private(set) var extracurricularActivities: [ECExtracurricularActivity] = []
    private(set) var entSubjects: [ENTSubject] = []
    private var profile: Profile?
    private var applications: [Application] = []

    // MARK: - EXPANDABLE PROVIDER
    private lazy var expandableProvider: ExpandableViewModelsProvider = {
        let view = ExpandableViewModelsProvider()
        view.onCellToggled = { [weak self] item in
            self?.view?.reconfigureItems(items: [item])
        }
        return view
    }()

    // MARK: - HEADER MENUVM
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

    // MARK: - EXPANDABLE PROVIDER
    private func configureExpandableProvider() {
        guard let profile else { return }
        
        expandableProvider.configure(profile: profile, actions: makeActions())
    }

    private func makeActions() -> ExpandableActions {
        ExpandableActions(
            didTapSavePersonalInfo: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.setPersonalInfo(name: $0, surname: $1, patronymic: $2, phoneNumber: nil)
            },
            didTapSaveFamilyInfo: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.setFamilyInfo(momPhoneNumber: $0, fatherPhoneNumber: $1)
            },
            didTapSaveEducation: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.setEducation(school: $0, finalClass: $1, score: $2)
            },
            didTapSaveEntYear: { [weak self] in
                guard let self else { return }
                self.view?.showLoading()
                self.interactor.setENTYear(year: $0)
            },
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
                    didAddNewSubject: self.didTapAddEntSubject
                )
                self.router.showAddEntSubjectPopUp(viewModel: vm)
            },
            didTapDeleteENTSubject: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteENTSubject(subject: $0)
            },
            
            didTapDeleteActivity: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteExtracurricular(activity: $0)
            },
            
            didTapDeleteOlympiad: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteOlympiad(olympiad: $0)
            }
        )
    }
    
    // MARK: - SNAPSHOT DISPATCH
    private func didSelectAnotherTab(newTab: AccountScreenTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab

        switch newTab {
        case .myUniversities:
            showUniversities()
        case .application:
            view?.showLoading()
            interactor.getProfile()
        case .main:
            showMain()
        }
    }

    // MARK: - SNAPSHOTS
    private func showUniversities() {
        let headerVM = makeHeaderVM(for: .myUniversities)
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

    private func showApplication() {
        let headerVM = makeHeaderVM(for: .application)

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

    private func showMain() {
        let headerVM = makeHeaderVM(for: .main)
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
    
    // MARK: - ACTIONS
    private func didTapAddEntSubject(subject: ENTSubject, score: String) {
        self.view?.showLoading()
        self.interactor.addENTSubject(subject: subject, score: score)
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
    
    func didPerformTask(message: String?, refreshID: ExpandableCellID?) {
        interactor.getProfile()
        if let message {
            self.view?.showMessage(message: message)
        }
        self.refreshID = refreshID
    }
    
    func didReceiveProfile(_ profile: Profile) {
        self.profile = profile
        configureExpandableProvider()
        self.view?.hideLoading()
        showApplication()
        
        if let refreshID, let item = expandableProvider.makeExpandableItem(for: refreshID) {
            view?.reconfigureItems(items: [item])
            view?.dismissPopup()
        }
    }
    
    func didReceiveProfileApplications(_ applications: [Application]) {
        self.applications = applications
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
        self.view?.hideLoading()
    }
    
    func didReceiveErrorInApplication(error: any Error, refreshID: ExpandableCellID?) {
        let userFacingError = errorService.handle(error)
        self.view?.showError(error: userFacingError)
        self.view?.hideLoading()
        
        if let refreshID, let item = expandableProvider.makeExpandableItem(for: refreshID) {
            view?.reconfigureItems(items: [item])
            view?.dismissPopup()
        }
    }
}
