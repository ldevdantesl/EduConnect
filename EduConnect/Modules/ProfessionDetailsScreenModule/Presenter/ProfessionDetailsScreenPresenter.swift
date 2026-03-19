//
//  ProfessionDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit

protocol ProfessionDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func didTapAccount()
    func didTapAppLogo()
    
    func didReceiveProfession(profession: ECProfession)
    func didReceiveRelated(professions: [ECProfession])
    func didReceiveSubjects(subjects: [ENTSubject])
    func didReceiveError(error: any Error)
}

final class ProfessionDetailsScreenPresenter {
    // MARK: - VIPER
    weak var view: ProfessionDetailsScreenViewProtocol?
    var router: ProfessionDetailsScreenRouterProtocol
    var interactor: ProfessionDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let dispatchGroup = DispatchGroup()
    private let errorService: ErrorServiceProtocol
    private let professionID: Int
    private var profession: ECProfession?
    private var related: [ECProfession] = []
    private var subjects: [ENTSubject] = []
    
    private var showingAllRelated: Bool = false

    init(interactor: ProfessionDetailsScreenInteractorProtocol, router: ProfessionDetailsScreenRouterProtocol, errorService: ErrorServiceProtocol, professionID: Int) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
        self.professionID = professionID
    }
    
    private func applySnapshot() {
        guard let profession else { return }
        let headerVM = ProfessionDetailsHeaderCellViewModel(profession: profession) { [weak self] in
            guard let self = self else { return }
            self.router.openSetENT(subjects: self.subjects)
        }
        let progsVM = ProfessionDetailsProgsAndUnisCellViewModel(profession: profession) { } didTapUniversities: { [weak self] in
            self?.router.routeToUniversities(filteredProfession: profession)
        }
        let aboutVM = ProfessionDetailsAboutCellViewModel(profession: profession)
        var relatedItems: [ProfessionDetailsItem] = []
        
        if !related.isEmpty {
            let relatedHeaderVM = SectionHeaderCellViewModel(
                title: ConstantLocalizedStrings.Profession.relatedProf,
                titleSize: 22, titleAlignment: .center
            )
            relatedItems.append(.sectionHeaderItem(.init(id: "related-header", viewModel: relatedHeaderVM)))
            let neededItems: [ECProfession] = showingAllRelated ? related : Array(related.prefix(1))
            
            neededItems.forEach { profession in
                let vm = CardWithImageCellViewModel(
                    imageURL: profession.imageURL,
                    preTitle: "\(profession.universitiesCount) \(ConstantLocalizedStrings.Profession.unis) \(profession.programsCount) \(ConstantLocalizedStrings.Profession.programs)",
                    title: profession.name.toCurrentLanguage(), subtitle: profession.description.toCurrentLanguage(), showsArrowRight: true,
                    didTap: { [weak self] in self?.router.routeToProfession(profession: profession) }
                )
                relatedItems.append(.cardWithImageItem(.init(item: profession, prefix: "professions-", viewModel: vm)))
            }
            
            let underlineVM = UnderlineButtonCellViewModel(
                titleName: showingAllRelated ? ConstantLocalizedStrings.Common.hide : ConstantLocalizedStrings.Common.hide,
                titleColor: .blue
            ) { [weak self] in
                self?.showingAllRelated.toggle()
                self?.applySnapshot()
            }
            relatedItems.append(.underlineItem(.init(viewModel: underlineVM)))
        }
        
        view?.applySnapshot(
            sections: [.header, .programsAndUniversities, .about, .related],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .programsAndUniversities : [.progsAndUnisItem(.init(id: "progsAndUnis", viewModel: progsVM))],
                .about : [.aboutItem(.init(id: "about", viewModel: aboutVM))],
                .related : relatedItems
            ]
        )
    }
}

extension ProfessionDetailsScreenPresenter: ProfessionDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        
        dispatchGroup.enter()
        interactor.getProfession(id: professionID)
        
        dispatchGroup.enter()
        interactor.getRelatedProfessions(id: professionID)
        
        dispatchGroup.enter()
        interactor.getSubjects()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.view?.hideLoading()
            self?.applySnapshot()
        }
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
    
    func didReceiveProfession(profession: ECProfession) {
        self.profession = profession
        dispatchGroup.leave()
    }
    
    func didReceiveRelated(professions: [ECProfession]) {
        self.related = professions
        dispatchGroup.leave()
    }
    
    func didReceiveSubjects(subjects: [ENTSubject]) {
        self.subjects = subjects
        dispatchGroup.leave()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.dispatchGroup.leave()
        self.view?.showError(error: userError)
        self.view?.hideLoading()
    }
}
