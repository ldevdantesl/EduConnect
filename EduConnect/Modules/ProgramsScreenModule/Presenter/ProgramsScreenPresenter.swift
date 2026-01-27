//
//  ProgramsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

protocol ProgramsScreenPresenterProtocol: AnyObject {
}

final class ProgramsScreenPresenter {
    weak var view: ProgramsScreenViewProtocol?
    var router: ProgramsScreenRouterProtocol
    var interactor: ProgramsScreenInteractorProtocol

    init(interactor: ProgramsScreenInteractorProtocol, router: ProgramsScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ProgramsScreenPresenter: ProgramsScreenPresenterProtocol {
}
