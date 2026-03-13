//
//  ProgramDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func didTapAccount()
    func didTapAppLogo()
    func didReceiveProgramDetails(details: ECProgramDetails)
    func didReceiveError(error: any Error)
}

final class ProgramDetailsScreenPresenter {
    
    // MARK: - VIPER
    weak var view: ProgramDetailsScreenViewProtocol?
    var router: ProgramDetailsScreenRouterProtocol
    var interactor: ProgramDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let programID: Int
    private let errorService: ErrorServiceProtocol
    private var programDetails: ECProgramDetails?
    
    init(interactor: ProgramDetailsScreenInteractorProtocol, router: ProgramDetailsScreenRouterProtocol, errorService: ErrorServiceProtocol, programID: Int) {
        self.interactor = interactor
        self.router = router
        self.programID = programID
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        
    }
}

extension ProgramDetailsScreenPresenter: ProgramDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor.getProgramDetails(programID: programID)
    }
    
    func didTapBack() {
        router.goBack()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didReceiveProgramDetails(details: ECProgramDetails) {
        self.programDetails = details
        view?.hideLoading()
        applySnapshot()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(error: userError)
    }
}
