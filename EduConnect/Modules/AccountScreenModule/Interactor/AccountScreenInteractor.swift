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
    func getProfile()
    func getProfileApplications()
    
    func addENTSubject(subject: ENTSubject, score: String)
    func setENTYear(year: Int)
    func deleteENTSubject(subject: ProfileETH.Subject)
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
    
    func getProfile() {
        Task {
            do {
                let profile = try await networkService.profile.getProfile()
                presenter?.didReceiveProfile(profile)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getProfileApplications() {
        Task {
            do {
                let applications = try await networkService.application.getApplications()
                presenter?.didReceiveProfileApplications(applications)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func deleteENTSubject(subject: ProfileETH.Subject) {
        Task {
            do {
                let response = try await networkService.profile.deleteETHSubject(subjectID: subject.id)
                presenter?.didPerformTask(message: response.message, refreshReason: .entChanged)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func addENTSubject(subject: ENTSubject, score: String) {
        Task {
            do {
                let response = try await networkService.profile.addETHSubjects(subjectID: subject.id, score: score)
                presenter?.didPerformTask(message: response.message, refreshReason: .entChanged)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func setENTYear(year: Int) {
        Task {
            do {
                let response = try await networkService.profile.updateETHYear(year: year)
                presenter?.didPerformTask(message: response.message, refreshReason: .entChanged)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
}
