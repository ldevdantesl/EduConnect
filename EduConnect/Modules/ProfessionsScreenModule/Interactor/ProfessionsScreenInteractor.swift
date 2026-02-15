//
//  ProfessionsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 14.02.2026
//

protocol ProfessionsScreenInteractorProtocol: AnyObject {
}

final class ProfessionsScreenInteractor: ProfessionsScreenInteractorProtocol {
    weak var presenter: ProfessionsScreenPresenterProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}
