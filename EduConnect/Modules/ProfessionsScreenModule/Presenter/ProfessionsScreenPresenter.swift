//
//  ProfessionsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenPresenterProtocol: AnyObject {
}

final class ProfessionsScreenPresenter {
    weak var view: ProfessionsScreenViewProtocol?
    var router: ProfessionsScreenRouterProtocol
    var interactor: ProfessionsScreenInteractorProtocol
    
    private let errorService: ErrorServiceProtocol

    init(interactor: ProfessionsScreenInteractorProtocol, router: ProfessionsScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
}

extension ProfessionsScreenPresenter: ProfessionsScreenPresenterProtocol {
}
