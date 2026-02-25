//
//  UniversityInfoScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenInteractorProtocol: AnyObject {
    func getUniversityByID(id: Int)
}

final class UniversityInfoScreenInteractor: UniversityInfoScreenInteractorProtocol {
    weak var presenter: UniversityInfoScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getUniversityByID(id: Int) {
        Task {
            do {
                let university = try await networkService.university.getUniversity(id: id)
                presenter?.didReceiveUniversity(university: university)
            } catch {
                presenter?.didReceieveError(error: error)
            }
        }
    }
}
