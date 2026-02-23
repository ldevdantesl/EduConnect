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
    func getOlympiadTypes()
    func getOlympiadPlaces()
    func getFamilyContacts()
    
    func getProfile()
    func getProfileApplications()
    
    func addFamilyMember(id: Int?, name: String?, phoneNumber: String?)
    func deleteFamilyMember(id: Int)
    
    func addENTSubject(subject: ENTSubject, score: String)
    func deleteENTSubject(subject: ProfileETH.Subject)
    
    func addOlympiad(olympiadTypeID: Int?, olympiadPlaceID: Int?, year: String?, files: [ECAttachedFile])
    func deleteOlympiad(olympiad: ProfileOlympiad)
    
    func addExtracurricular(id: Int?, description: String?, files: [ECAttachedFile])
    func deleteExtracurricular(activity: ProfileExtracurricular)
    
    func setPersonalInfo(name: String?, surname: String?, patronymic: String?, phoneNumber: String?)
    func setEducation(school: String?, finalClass: String?, score: Double?)
    func setFamilyInfo(momPhoneNumber: String?, fatherPhoneNumber: String?)
    func setENTYear(year: Int)
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
    
    func getOlympiadTypes() {
        Task {
            do {
                let response = try await networkService.references.getOlympiadTypes()
                presenter?.didReceiveOlympiadTypes(types: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getOlympiadPlaces() {
        Task {
            do {
                let response = try await networkService.references.getOlympiadPlaces()
                presenter?.didReceiveOlympiadPlaces(places: response)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func getFamilyContacts() {
        Task {
            do {
                let response = try await networkService.references.getFamilyMembers()
                presenter?.didReceiveFamilyContacts(contacts: response)
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
    
    func addFamilyMember(id: Int?, name: String?, phoneNumber: String?) {
        Task {
            do {
                let response = try await networkService.profile.addFamilyMember(familyMemberID: id, fullName: name, phoneNumber: phoneNumber)
                presenter?.didPerformTask(message: response.message, refreshID: .familyInfo)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .familyInfo)
            }
        }
    }
    
    func deleteFamilyMember(id: Int) {
        Task {
            do {
                let response = try await networkService.profile.deleteFamilyMember(familyMemberID: id)
                presenter?.didPerformTask(message: response.message, refreshID: .familyInfo)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .familyInfo)
            }
        }
    }
    
    func addENTSubject(subject: ENTSubject, score: String) {
        Task {
            do {
                let response = try await networkService.profile.addETHSubjects(subjectID: subject.id, score: score)
                presenter?.didPerformTask(message: response.message, refreshID: .ENT)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .ENT)
            }
        }
    }
    
    func deleteENTSubject(subject: ProfileETH.Subject) {
        Task {
            do {
                let response = try await networkService.profile.deleteETHSubject(subjectID: subject.id)
                presenter?.didPerformTask(message: response.message, refreshID: .ENT)
            } catch {
                presenter?.didReceiveError(error: error)
            }
        }
    }
    
    func setPersonalInfo(name: String?, surname: String?, patronymic: String?, phoneNumber: String?) {
        Task {
            do {
                let response = try await networkService.profile.updatePersonal(surname: surname, name: name, patronymic: patronymic, phoneNumber: phoneNumber)
                presenter?.didPerformTask(message: response.message, refreshID: .personalInfo)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .personalInfo)
            }
        }
    }
    
    func setEducation(school: String?, finalClass: String?, score: Double?) {
        Task {
            do {
                let response = try await networkService.profile.updateEducation(institution: school, finalClass: finalClass, score: score)
                presenter?.didPerformTask(message: response.message, refreshID: .education)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .education)
            }
        }
    }
    
    func setFamilyInfo(momPhoneNumber: String?, fatherPhoneNumber: String?) {
        Task {
            do {
                let response = try await networkService.profile.addFamilyMember(familyMemberID: 6, fullName: "", phoneNumber: momPhoneNumber)
                let response2 = try await networkService.profile.addFamilyMember(familyMemberID: 7, fullName: "", phoneNumber: fatherPhoneNumber)
                presenter?.didPerformTask(message: "\(response.message ?? "")\n\(response2.message ?? "")", refreshID: .familyInfo)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .familyInfo)
            }
        }
    }
    
    func setENTYear(year: Int) {
        Task {
            do {
                let response = try await networkService.profile.updateETHYear(year: year)
                presenter?.didPerformTask(message: response.message, refreshID: .ENT)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .ENT)
            }
        }
    }
    
    func addOlympiad(olympiadTypeID: Int?, olympiadPlaceID: Int?, year: String?, files: [ECAttachedFile]) {
        Task {
            do {
                let response = try await networkService.profile.addOlympiad(olympiadTypeID: olympiadTypeID, olympiadPlaceID: olympiadPlaceID, year: year, files: files)
                presenter?.didPerformTask(message: response.message, refreshID: .olympiads)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .olympiads)
            }
        }
    }
    
    func deleteOlympiad(olympiad: ProfileOlympiad) {
        Task {
            do {
                let response = try await networkService.profile.deleteOlympiad(olympiadID: olympiad.id)
                presenter?.didPerformTask(message: response.message, refreshID: .olympiads)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .olympiads)
            }
        }
    }
    
    func addExtracurricular(id: Int?, description: String?, files: [ECAttachedFile]) {
        Task {
            do {
                let response = try await networkService.profile.addExtracurricular(activityID: id, description: description, files: files)
                presenter?.didPerformTask(message: response.message, refreshID: .extracurricular)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .extracurricular)
            }
        }
    }
    
    func deleteExtracurricular(activity: ProfileExtracurricular) {
        Task {
            do {
                let response = try await networkService.profile.deleteExtracurricular(activityID: activity.id)
                presenter?.didPerformTask(message: response.message, refreshID: .extracurricular)
            } catch {
                presenter?.didReceiveErrorInApplication(error: error, refreshID: .extracurricular)
            }
        }
    }
}
