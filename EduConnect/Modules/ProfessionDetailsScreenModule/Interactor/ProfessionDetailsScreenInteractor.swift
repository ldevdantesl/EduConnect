//
//  ProfessionDetailsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

protocol ProfessionDetailsScreenInteractorProtocol: AnyObject {
    func getProfession(id: Int)
    func getRelatedProfessions(id: Int)
    func getSubjects()
}

final class ProfessionDetailsScreenInteractor: ProfessionDetailsScreenInteractorProtocol {
    weak var presenter: ProfessionDetailsScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProfession(id: Int) {
        Task {
            do {
                let profession = try await networkService.professions.getProfessionDetails(professionID: id)
                presenter?.didReceiveProfession(profession: profession)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getRelatedProfessions(id: Int) {
        Task {
            do {
                let professions = try await networkService.professions.getRelatedForProfession(professionID: id, limit: 3)
                presenter?.didReceiveRelated(professions: professions)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getSubjects() {
        Task {
            do {
                let subjects = try await networkService.references.getSubjects()
                presenter?.didReceiveSubjects(subjects: subjects)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
