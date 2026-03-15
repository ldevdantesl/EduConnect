//
//  ProgramsByCategoryScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramsByCategoryScreenInteractorProtocol: AnyObject {
    func getPrograms(categoryID: Int)
}

final class ProgramsByCategoryScreenInteractor: ProgramsByCategoryScreenInteractorProtocol {
    weak var presenter: ProgramsByCategoryScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getPrograms(categoryID: Int) {
        Task {
            do {
                let programs = try await networkService.programs.getProgramsOfCategory(categoryID: categoryID)
                presenter?.didReceiveProgramsByCategory(programs: programs)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
