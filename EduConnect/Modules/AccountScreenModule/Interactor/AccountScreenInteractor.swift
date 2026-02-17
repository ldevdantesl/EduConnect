//
//  HomeScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit

protocol AccountScreenInteractorProtocol: AnyObject {
    func getEntSubjects()
    func getExtracurricularActivities()
}

final class AccountScreenInteractor: AccountScreenInteractorProtocol {
    weak var presenter: AccountScreenPresenterProtocol?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getEntSubjects() {
        Task {
            do {
                let subjects = try await networkService.references.getSubjects()
                presenter?.didReceiveENTSubjects(entSubjects: subjects)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getExtracurricularActivities() {
        Task {
            do {
                let activities = try await networkService.references.getExtracurricularActivities()
                presenter?.didReceiveExtracurricularActivities(activities: activities)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
