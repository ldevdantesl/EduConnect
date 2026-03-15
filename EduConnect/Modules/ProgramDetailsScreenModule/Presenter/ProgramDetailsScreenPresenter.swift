//
//  ProgramDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func didTapAccount()
    func didTapAppLogo()
    
    func didReceiveUniversity(university: ECUniversity)
    func didReceiveProgramDetails(details: ECProgramDetails)
    func didReceiveRelatedPrograms(programs: [ECProgram])
    func didReceiveError(error: any Error)
}

final class ProgramDetailsScreenPresenter {
    
    // MARK: - VIPER
    weak var view: ProgramDetailsScreenViewProtocol?
    var router: ProgramDetailsScreenRouterProtocol
    var interactor: ProgramDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let programID: Int
    private let errorService: ErrorServiceProtocol
    private let dispatchGroup = DispatchGroup()
    
    private var programDetails: ECProgramDetails?
    private var university: ECUniversity?
    private var relatedPrograms: [ECProgram] = []
    
    init(interactor: ProgramDetailsScreenInteractorProtocol, router: ProgramDetailsScreenRouterProtocol, errorService: ErrorServiceProtocol, programID: Int) {
        self.interactor = interactor
        self.router = router
        self.programID = programID
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        guard let programDetails, let university else { return }
        let headerVM = ProgramDetailsHeaderCellViewModel(programDetails: programDetails, university: university)
        let universityHeader = SectionHeaderCellViewModel(title: "Университет", titleSize: 20, titleAlignment: .center)
        let universityItemVM = ProgramDetailsUniversityCardCellViewModel(university: university) { [weak self] _ in
            self?.router.routeToUniversity(university: university)
        }
        
        let aboutHeader = SectionHeaderCellViewModel(title: "О Программе", titleSize: 20, titleAlignment: .center)
        let aboutVM = ProgramDetailsAboutCellViewModel(details: programDetails)
        
        var professionItems: [ProgramDetailsItem] = []
        if !programDetails.professions.isEmpty {
            let professionsHeader = SectionHeaderCellViewModel(title: "Связанные Профессии", titleSize: 20, titleAlignment: .center)
            professionItems.append(.sectionHeaderItem(.init(id: "professionHeader", viewModel: professionsHeader)))
            let professionSubItems: [ProgramDetailsItem] = programDetails.professions.map { profession in
                let cardVM = CardWithImageCellViewModel(imageURL: profession.imageURL, title: profession.name.toCurrentLanguage(), showsArrowRight: true) { [weak self] in self?.router.routeToProfession(professionID: profession.id) }
                return .cardWithImageItem(.init(item: profession, prefix: "profession-", viewModel: cardVM))
            }
            professionItems.append(contentsOf: professionSubItems)
        }
         
        var facultyItems: [ProgramDetailsItem] = []
        if !programDetails.faculties.isEmpty {
            let facultyHeader = SectionHeaderCellViewModel(title: "Факультеты", titleSize: 20, titleAlignment: .center)
            facultyItems.append(.sectionHeaderItem(.init(id: "faculty-header", viewModel: facultyHeader)))
            let facultySubItems: [ProgramDetailsItem] = programDetails.faculties.map { faculty in
                let cardVM = CardWithImageCellViewModel(imageURL: faculty.imageURL, title: faculty.name.toCurrentLanguage(), subtitle: "Код: \(faculty.code)")
                return .cardWithImageItem(.init(item: faculty, prefix: "faculty-", viewModel: cardVM))
            }
            facultyItems.append(contentsOf: facultySubItems)
        }
        
        let relatedVM = SectionHeaderCellViewModel(title: "Похожие программы", titleSize: 20, titleAlignment: .center)
        let relatedHeaderItems: [ProgramDetailsItem] = relatedPrograms.isEmpty ? [] : [.sectionHeaderItem(.init(id: "related-header", viewModel: relatedVM))]
        
        var relatedItems: [ProgramDetailsItem] = []
        if !relatedPrograms.isEmpty {
            let relatedSubItems: [ProgramDetailsItem] = relatedPrograms.map { program in
                let itemVM = DashedProgramCellViewModel(program: program) { [weak self] in self?.router.routeToProgram(program: program) }
                return .programItem(.init(item: program, prefix: "related-program-", viewModel: itemVM))
            }
            relatedItems.append(contentsOf: relatedSubItems)
        }
        
        view?.applySnapshot(
            sections: [.header, .body, .professions, .facutlies, .relatedHeader, .related],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .body : [
                    .sectionHeaderItem(.init(id: "university-header", viewModel: universityHeader)),
                    .universityItem(.init(item: university, prefix: "university-", viewModel: universityItemVM)),
                    .sectionHeaderItem(.init(id: "about-header", viewModel: aboutHeader)),
                    .aboutItem(.init(id: "about", viewModel: aboutVM))
                ],
                .professions : professionItems,
                .facutlies: facultyItems,
                .relatedHeader : relatedHeaderItems,
                .related : relatedItems
            ]
        )
    }
}

extension ProgramDetailsScreenPresenter: ProgramDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor.getProgramDetails(programID: programID)
    }
    
    func didTapBack() {
        router.goBack()
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didReceiveProgramDetails(details: ECProgramDetails) {
        self.programDetails = details
        
        dispatchGroup.enter()
        interactor.getUniversity(universityID: details.universityID)
        
        dispatchGroup.enter()
        interactor.getRelated(programID: programID)
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.applySnapshot()
        }
    }
    
    func didReceiveUniversity(university: ECUniversity) {
        self.university = university
        dispatchGroup.leave()
    }
    
    func didReceiveRelatedPrograms(programs: [ECProgram]) {
        self.relatedPrograms = programs
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(error: userError)
        router.goBack()
    }
}
