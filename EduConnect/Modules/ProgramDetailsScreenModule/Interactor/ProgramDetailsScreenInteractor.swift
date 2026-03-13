//
//  ProgramDetailsScreenInteractor.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramDetailsScreenInteractorProtocol: AnyObject {
    func getProgramDetails(programID: Int)
}

final class ProgramDetailsScreenInteractor: ProgramDetailsScreenInteractorProtocol {
    weak var presenter: ProgramDetailsScreenPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getProgramDetails(programID: Int) {
        Task {
            do {
                let details = try await networkService.programs.getProgramDetails(programID: programID)
                self.presenter?.didReceiveProgramDetails(details: details)
            } catch {
                self.presenter?.didReceiveError(error: error)
            }
        }
    }
}
