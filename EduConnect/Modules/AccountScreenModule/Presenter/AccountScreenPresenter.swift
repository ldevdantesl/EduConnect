//
//  AccountScreenPresenter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func didTapTabBar()
    func didTapAppLogo()
    var selectedTab: AccountScreenTab { get set }
    var headerMenuViewModel: AccountScreenSegmentedReusableMenuViewModel { get }

    func didRequestDeletionCode(message: String?)
    func didConfirmDeletion(message: String?)
    func didLogOut()
    
    func didPerformTask(message: String?, refreshID: ExpandableCellID?)
    func didReceiveProfile(_ profile: Profile)
    func didFetchProfile(_ profile: Profile)
    func didFetchProfileApplications(_ applications: [Application], tab: AccountScreenTab)
    func didReceiveProfileApplications(_ applications: [Application])
    func didReceiveENTSubjects(entSubjects: [ENTSubject])
    func didReceiveOlympiadPlaces(places: [ECOlympiadPlace])
    func didReceiveOlympiadTypes(types: [ECOlympiadType])
    func didReceiveFamilyContacts(contacts: [ECFamilyMember])
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
    private(set) var familyContacts: [ECFamilyMember] = []
    private(set) var entSubjects: [ENTSubject] = []
    private(set) var olympiadTypes: [ECOlympiadType] = []
    private(set) var olympiadPlaces: [ECOlympiadPlace] = []
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
            
            didTapAddFamilyMember: { [weak self] in
                guard let self = self else { return }
                let vm = AddFamilyMemberPopUpViewModel(
                    familyMembers: self.familyContacts,
                    onClose: self.view?.dismissPopup,
                    didAddNewFamilyMember: self.didTapAddFamilyMember,
                )
                self.router.showPopUp(viewModel: vm)
            },
            
            didTapDeleteFamilyMember: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteFamilyMember(id: $0.id)
            },
            
            didTapAddActivity: { [weak self] in
                guard let self else { return }
                let vm = AddExtracurricularActivityPopUpViewModel(
                    activities: self.extracurricularActivities,
                    onClose: self.view?.dismissPopup,
                    didAddNewActivity: self.didTapAddExtracurricular
                )
                self.router.showPopUp(viewModel: vm)
            },
            
            didTapDeleteActivity: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteExtracurricular(activity: $0)
            },
            
            didTapAddOlympiad: { [weak self] in
                guard let self = self else { return }
                let vm = AddOlympiadPopUpViewModel(
                    olympiadTypes: self.olympiadTypes,
                    olympiadPlaces: self.olympiadPlaces,
                    onClose: self.view?.dismissPopup,
                    didAddNewOlympiad: self.didTapAddOlympiad
                )
                self.router.showPopUp(viewModel: vm)
            },
            
            didTapDeleteOlympiad: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteOlympiad(olympiad: $0)
            },
            
            didTapAddENTSubject: { [weak self] in
                guard let self else { return }
                let vm = AddENTSubjectPopUpViewModel(
                    entSubjects: self.entSubjects,
                    onClose: self.view?.dismissPopup,
                    didAddNewSubject: self.didTapAddEntSubject
                )
                self.router.showPopUp(viewModel: vm)
            },
            
            didTapDeleteENTSubject: { [weak self] in
                guard let self = self else { return }
                self.view?.showLoading()
                self.interactor.deleteENTSubject(subject: $0)
            }
        )
    }
    
    // MARK: - SNAPSHOT DISPATCH
    private func didSelectAnotherTab(newTab: AccountScreenTab) {
        guard selectedTab != newTab else { return }
        selectedTab = newTab

        switch newTab {
        case .myUniversities:
            view?.showLoading()
            interactor.refetchApplications(tab: .myUniversities)
        case .application:
            showApplication()
        case .main:
            view?.showLoading()
            interactor.refetchApplications(tab: .main)
        }
    }

    // MARK: - SNAPSHOTS
    private func showUniversities() {
        let headerVM = makeHeaderVM(for: .myUniversities)
        
        var applicationItems: [AccountScreenItem] = [
            .headerItem(.init(id: "header", viewModel: headerVM)),
        ]
        
        if !applications.isEmpty {
            let universities: [AccountScreenItem] = applications.map {
                let vm = ApplicationCellViewModel(application: $0) { [weak self] application in
                    self?.router.routeToUniversityByID(id: application.university.id)
                }
                return .university(.init(item: $0, prefix: "application-", viewModel: vm))
            }
            
            applicationItems.append(contentsOf: universities)
        } else {
            let notFoundVm = NotFoundCellViewModel(
                systemImage: ImageConstants.SystemImages.questionMark.rawValue,
                title: ConstantLocalizedStrings.Words.notFound,
                subtitle: ConstantLocalizedStrings.Account.ApplicationTab.applicationsNotFound
            ) { [weak self] in
                self?.router.routeToUniversities()
            }
            applicationItems.append(.notFoundItem(.init(viewModel: notFoundVm)))
        }

        view?.applySnapshot(
            sections: [.universities],
            itemsBySection: [
                .universities: applicationItems
            ]
        )
    }

    private func showApplication() {
        expandableProvider.collapseAll()
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
        var items: [AccountScreenItem] = []
        let headerVM = makeHeaderVM(for: .main)
        let infoVM = AccountScreenMainTabInfoCellViewModel()
        items.append(.headerItem(.init(id: "header", viewModel: headerVM)))
        items.append(.mainTabInfo(.init(id: "info", viewModel: infoVM)))
        
        if !applications.isEmpty {
            let applicationsHeader = HeaderWithSubtitleCellViewModel(
                title: ConstantLocalizedStrings.Account.MainTab.lastApplications,
                subtitle: ConstantLocalizedStrings.Account.MainTab.lastApplicationsSubtitle
            )
            items.append(.headerWithSubtitleItem(.init(id: "applications-header", viewModel: applicationsHeader)))
            
            applications.forEach {
                let vm = AccountPendingApplicationsCellViewModel(application: $0, didTapUniversity: router.routeToUniversityByID)
                items.append(.pendingApplicationItem(.init(item: $0, prefix: "main-application-", viewModel: vm)))
            }
        }
        
        let deleteAccountVM = AccountScreenDeleteAccountCellViewModel { [weak self] in self?.didTapDelete() }
        items.append(.deleteAccountItem(.init(id: "delete-account", viewModel: deleteAccountVM)))

        view?.applySnapshot(
            sections: [.main],
            itemsBySection: [
                .main: items
            ]
        )
    }

    // MARK: - HELPERS
    private func makeHeaderVM(for tab: AccountScreenTab) -> SectionHeaderCellViewModel {
        var title = tab.tabTitles
        if tab == .main, let name = profile?.name {
            title.append(", \(name)")
        }
        return SectionHeaderCellViewModel(title: title, titleSize: 26)
    }
    
    // MARK: - ACTIONS
    private func didTapAddFamilyMember(id: Int?, name: String?, phoneNumber: String?) {
        self.view?.showLoading()
        self.interactor.addFamilyMember(id: id, name: name, phoneNumber: phoneNumber)
    }
    
    private func didTapAddEntSubject(subject: ENTSubject, score: String) {
        self.view?.showLoading()
        self.interactor.addENTSubject(subject: subject, score: score)
    }
    
    private func didTapAddOlympiad(typeID: Int?, placeID: Int?, year: String?, files: [ECAttachedImage]) {
        self.view?.showLoading()
        self.interactor.addOlympiad(olympiadTypeID: typeID, olympiadPlaceID: placeID, year: year, files: files)
    }
    
    private func didTapAddExtracurricular(id: Int?, description: String?, files: [ECAttachedImage]) {
        self.view?.showLoading()
        self.interactor.addExtracurricular(id: id, description: description, files: files)
    }
    
    private func didTapDelete() {
        self.view?.presentAlert(
            title: "Delete Account",
            message: "You sure you want to delete your account. All your data will be lost",
            confirmButtonName: ConstantLocalizedStrings.Common.confirm
        ) { [weak self] in
            self?.view?.showLoading()
            self?.interactor.requestDeletionCode(email: self?.profile?.email)
        }
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
        
        dispatchGroup.enter()
        interactor.getOlympiadTypes()
        
        dispatchGroup.enter()
        interactor.getOlympiadPlaces()
        
        dispatchGroup.enter()
        interactor.getFamilyContacts()
        
        dispatchGroup.enter()
        interactor.getProfile()
        
        dispatchGroup.enter()
        interactor.getProfileApplications()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.configureExpandableProvider()
            self?.didSelectAnotherTab(newTab: .main)
        }
    }
    
    func viewDidAppear() {
        switch selectedTab {
        case .myUniversities:
            view?.showLoading()
            interactor.refetchApplications(tab: .myUniversities)
        case .main:
            view?.showLoading()
            interactor.refetchApplications(tab: .main)
        default: break
        }
    }

    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didTapTabBar() {
        router.showSidebar()
    }
    
    func didRequestDeletionCode(message: String?) {
        self.view?.hideLoading()
        if let message {
            self.view?.showMessage(message: message)
        }
        let confirmDeletionPopVM = ConfirmDeletionPopUpViewModel(email: profile?.email) { email, code in
            self.view?.showLoading()
            self.interactor.confirmDeletion(email: email, code: code)
        } onClose: {
            self.view?.dismissPopup()
        }

        self.router.showPopUp(viewModel: confirmDeletionPopVM)
    }
    
    func didConfirmDeletion(message: String?) {
        self.view?.hideLoading()
        self.view?.dismissPopup()
        if let message {
            self.view?.showMessage(message: message)
        }
        self.interactor.logOut()
    }
    
    func didLogOut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.router.routeToLogin()
        }
    }
    
    func didPerformTask(message: String?, refreshID: ExpandableCellID?) {
        interactor.refetchProfile()
        if let message {
            self.view?.showMessage(message: message)
        }
        self.refreshID = refreshID
    }
    
    func didReceiveProfile(_ profile: Profile) {
        self.profile = profile
        dispatchGroup.leave()
    }
    
    func didFetchProfile(_ profile: Profile) {
        self.profile = profile
        configureExpandableProvider()
        self.view?.hideLoading()
        
        if selectedTab == .application {
            showApplication()
        }
        
        if let refreshID {
            expandableProvider.expand(refreshID)
            if let item = expandableProvider.makeExpandableItem(for: refreshID) {
                view?.reconfigureItems(items: [item])
            }
            view?.dismissPopup()
            self.refreshID = nil
        }
    }
    
    func didReceiveProfileApplications(_ applications: [Application]) {
        self.applications = applications
        dispatchGroup.leave()
    }
    
    func didFetchProfileApplications(_ applications: [Application], tab: AccountScreenTab) {
        self.applications = applications
        view?.hideLoading()
        tab == .myUniversities ? showUniversities() : showMain()
    }
    
    func didReceiveENTSubjects(entSubjects: [ENTSubject]) {
        self.entSubjects = entSubjects
        dispatchGroup.leave()
    }
    
    func didReceiveOlympiadTypes(types: [ECOlympiadType]) {
        self.olympiadTypes = types
        dispatchGroup.leave()
    }
    
    func didReceiveOlympiadPlaces(places: [ECOlympiadPlace]) {
        self.olympiadPlaces = places
        dispatchGroup.leave()
    }
    
    func didReceiveFamilyContacts(contacts: [ECFamilyMember]) {
        self.familyContacts = contacts
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
