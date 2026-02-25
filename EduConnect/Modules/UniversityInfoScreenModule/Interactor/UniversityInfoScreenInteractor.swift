//
//  UniversityInfoScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 30.01.2026
//

import UIKit

protocol UniversityInfoScreenInteractorProtocol: AnyObject {
    func getUniversityByID(id: Int)
    func applyToUniversity(id: Int)
    func removeApplication(applicationID: Int)
    func getApplicationStatus(id: Int)
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
    
    func applyToUniversity(id: Int) {
        Task {
            do {
                let response: EduConnectResponse = try await networkService.application.apply(universityID: id)
                presenter?.didApplyOrDeleteApplication(message: response.message)
            } catch {
                presenter?.didReceieveError(error: error)
            }
        }
    }
    
    func removeApplication(applicationID: Int) {
        Task {
            do {
                let response: EduConnectResponse = try await networkService.application.delete(applicationID: applicationID)
                presenter?.didApplyOrDeleteApplication(message: response.message)
            } catch {
                presenter?.didReceieveError(error: error)
            }
        }
    }
    
    func getApplicationStatus(id: Int) {
        Task {
            do {
                let application = try await networkService.application.applicationStatus(universityID: id)
                presenter?.didGetApplicationStatus(application: application)
            } catch {
                presenter?.didFailToGetApplicationStatus()
            }
        }
    }
}
