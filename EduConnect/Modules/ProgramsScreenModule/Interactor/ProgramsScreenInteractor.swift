//
//  ProgramsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

protocol ProgramsScreenInteractorProtocol: AnyObject {
}

final class ProgramsScreenInteractor: ProgramsScreenInteractorProtocol {
    weak var presenter: ProgramsScreenPresenterProtocol?
}
