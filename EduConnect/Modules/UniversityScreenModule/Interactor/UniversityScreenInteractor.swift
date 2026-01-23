//
//  UniversityScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

protocol UniversityScreenInteractorProtocol: AnyObject {
}

final class UniversityScreenInteractor: UniversityScreenInteractorProtocol {
    weak var presenter: UniversityScreenPresenterProtocol?
}
