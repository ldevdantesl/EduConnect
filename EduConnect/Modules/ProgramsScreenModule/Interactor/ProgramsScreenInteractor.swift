//
//  ProgramsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.01.2026
//

import UIKit

protocol ProgramsScreenInteractorProtocol: AnyObject {
    func getPrograms()
}

final class ProgramsScreenInteractor: ProgramsScreenInteractorProtocol {
    weak var presenter: ProgramsScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getPrograms() {
        Task {
            do {
                let programs = try await networkService.references.getProgramCategories()
                presenter?.didReceivePrograms(programs)
            } catch {
                await MainActor.run { [weak self] in
                    self?.presenter?.didReceieveError(error: error)
                }
            }
        }
    }
}
