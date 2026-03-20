//
//  ProgramsByCategoryScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit

protocol ProgramsByCategoryScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapBack()
    func didTapAccount()
    func didTapAppLogo()
    func didReceiveProgramsByCategory(programs: [ECProgram])
    func didReceiveError(error: any Error)
}

final class ProgramsByCategoryScreenPresenter {
    
    // MARK: - VIPER
    weak var view: ProgramsByCategoryScreenViewProtocol?
    var router: ProgramsByCategoryScreenRouterProtocol
    var interactor: ProgramsByCategoryScreenInteractorProtocol

    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private let category: ECProgramCategory
    private var programs: [ECProgram] = []
    
    // MARK: - COMPUTED PROPERTIES
    private var totalPrograms: Int {
        programs.count
    }
    
    private var totalUnis: Int {
        Set(programs.map { $0.universityID }).count
    }
    
    init(interactor: ProgramsByCategoryScreenInteractorProtocol, router: ProgramsByCategoryScreenRouterProtocol, errorService: ErrorServiceProtocol, category: ECProgramCategory) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
        self.category = category
    }
    
    private func applySnapshot() {
        let headerVM = ProgramsByCategoryHeaderCellViewModel(totalPrograms: totalPrograms, totalUnis: totalUnis, programCategory: category)
        let headerSubtitleVM = HeaderWithSubtitleCellViewModel(
            title: ConstantLocalizedStrings.Program.ByCategory.title,
            subtitle: category.name.toCurrentLanguage(),
            subtitleSize: 20, subtitleColor: .black, alignment: .center
        )
        let footerVM = TabsFooterCellViewModel(
            titleLabelText: category.name.toCurrentLanguage(),
            subtitleLabelText: ConstantLocalizedStrings.Program.ByCategory.footerSubtitle
        )
        
        let bodyItems: [ProgramsByCategoryItem] = programs.map { program in
            let vm = DashedProgramCellViewModel(program: program) { [weak self] in self?.router.routeToDetails(program: program)}
            return .dashedProgramItem(.init(item: program, prefix: "program-", viewModel: vm))
        }
        
        var footerItems: [ProgramsByCategoryItem] = []
        
        if programs.isEmpty {
            let notFoundVM = NotFoundCellViewModel(
                image: ImageConstants.SystemImages.questionMark.image,
                subtitle: ConstantLocalizedStrings.Program.ByCategory.error,
                horizontallySpaced: true)
            footerItems.append(.notFoundItem(.init(viewModel: notFoundVM)))
        }
        
        footerItems.append(.footerItem(.init(id: "footer", viewModel: footerVM)))
        
        view?.applySnapshot(
            sections: [.header, .body, .footer],
            itemsBySection: [
                .header : [
                    .headerItem(.init(id: "header", viewModel: headerVM)),
                    .headerWithSubtitleItem(.init(id: "categoryHeader", viewModel: headerSubtitleVM))
                ],
                .body : bodyItems,
                .footer : footerItems
            ]
        )
    }
}

extension ProgramsByCategoryScreenPresenter: ProgramsByCategoryScreenPresenterProtocol {
    func viewDidLoad() {
        view?.showLoading()
        interactor.getPrograms(categoryID: category.id)
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
    
    func didReceiveProgramsByCategory(programs: [ECProgram]) {
        self.programs = programs
        applySnapshot()
        view?.hideLoading()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(error: userError)
    }
}
