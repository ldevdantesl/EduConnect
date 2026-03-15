//
//  UniversityInfoScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAccount()
    func didTapAppLogo()
    func didTapBack()
    func didGetApplicationStatus(application: Application)
    func didFailToGetApplicationStatus()
    func didApplyOrDeleteApplication(message: String?)
    func didReceiveUniversity(university: ECUniversity)
    func didReceieveError(error: any Error)
}

final class UniversityInfoScreenPresenter {
    weak var view: UniversityInfoScreenViewProtocol?
    var router: UniversityInfoScreenRouterProtocol
    var interactor: UniversityInfoScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol
    private let universityID: Int
    private var university: ECUniversity?
    private var application: Application?
    
    private var applied: Bool { application != nil }
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - SNAPSHOTING
    private let snapshotBuilder = UniversityInfoScreenSnapshotBuilder()
    
    private lazy var actions = UniversityInfoScreenSnapshotBuilder.Actions(
        didTapAboutFaculty: { [weak self] in self?.view?.scrollToSection(section: .faculties) },
        didTapAboutProgram: { [weak self] in self?.view?.scrollToSection(section: .programs) },
        didTapAboutProfession: { [weak self] in self?.view?.scrollToSection(section: .professions) },
        didTapApply: { [weak self] in self?.didTapApply() },
        didTapRemoveApplication: { [weak self] in self?.didTapRemoveApplication() },
        didTapProfession: { [weak self] in self?.router.routeToProfession(professionID: $0) },
        didTapProgram: { [weak self] in self?.router.routeToProgram(programID: $0) } 
    )

    init(
        interactor: UniversityInfoScreenInteractorProtocol,
        router: UniversityInfoScreenRouterProtocol,
        errorService: ErrorServiceProtocol,
        university: ECUniversity
    ) {
        self.interactor = interactor
        self.errorService = errorService
        self.router = router
        self.universityID = university.id
        self.university = university
    }
    
    init(
        interactor: UniversityInfoScreenInteractorProtocol,
        router: UniversityInfoScreenRouterProtocol,
        errorService: ErrorServiceProtocol,
        universityID: Int
    ) {
        self.interactor = interactor
        self.errorService = errorService
        self.router = router
        self.universityID = universityID
    }
    
    private func applySnapshot() {
        guard let university else { return }
        let result = snapshotBuilder.build(university: university, applied: applied, actions: actions)
        view?.applySnapshot(sections: result.sections, itemsBySection: result.items)
    }
    
    private func didTapApply() {
        self.view?.showLoading()
        self.interactor.applyToUniversity(id: self.universityID)
    }
    
    private func didTapRemoveApplication() {
        guard let application else { return }
        self.view?.showLoading()
        self.interactor.removeApplication(applicationID: application.id)
    }
}

extension UniversityInfoScreenPresenter: UniversityInfoScreenPresenterProtocol {
    func viewDidLoad() {
        self.view?.showLoading()
        
        if university == nil {
            dispatchGroup.enter()
            self.interactor.getUniversityByID(id: universityID)
        }
        
        dispatchGroup.enter()
        interactor.getApplicationStatus(id: universityID)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.applySnapshot()
            self?.view?.hideLoading()
        }
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapBack() {
        router.goBack()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didGetApplicationStatus(application: Application) {
        self.application = application
        dispatchGroup.leave()
    }
    
    func didFailToGetApplicationStatus() {
        self.application = nil
        dispatchGroup.leave()
    }
    
    func didApplyOrDeleteApplication(message: String?) {
        dispatchGroup.enter()
        interactor.getApplicationStatus(id: universityID)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.applySnapshot()
            guard let message else { return }
            self?.view?.showMessage(message: message)
        }
    }
    
    func didReceiveUniversity(university: ECUniversity) {
        self.university = university
        dispatchGroup.leave()
    }
    
    func didReceieveError(error: any Error) {
        let userError = errorService.handle(error)
        self.dispatchGroup.leave()
        self.view?.showError(userError: userError)
        self.view?.hideLoading()
    }
}
