//
//  MainScreenSnapshotBuilder.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import UIKit

struct MainScreenSnapshotBuilder {
    
    struct State {
        let showingAllSteps: Bool
        let selectedAcademicTab: MainScreenAcademicCellViewModel.AcademicTab
        let selectedJournalTab: ECNewsType?
        let universities: [ECUniversity]
        let programCategories: [ECProgramCategory]
        let professions: [ECProfession]
        let newsTypes: [ECNewsType]
        let allNews: [ECNews]
        let newsByTypeId: [Int?: [ECNews]]
    }
    
    struct Actions {
        let didTapStepsENT: () -> Void
        let didTapStepsProfession: () -> Void
        let didTapStepsUniversity: () -> Void
        let didTapShowAllSteps: () -> Void
        let didTapUniversity: (ECUniversity) -> Void
        let didTapProfession: (ECProfession) -> Void
        let didTapArticle: (ECNews) -> Void
        let didTapShowAllPrograms: () -> Void
        let didTapShowAllProfessions: () -> Void
        let didTapShowAllUniversities: () -> Void
        let didTapShowAllArticles: () -> Void
        let didTapServicesProfession: () -> Void
        let didTapServicesUniversity: () -> Void
        let didTapServicesCalendar: () -> Void
        let didSelectAcademicTab: (MainScreenAcademicCellViewModel.AcademicTab) -> Void
        let didSelectJournalType: (ECNewsType?) -> Void
    }
    
    func build(
        state: State,
        actions: Actions,
        isLoadingOnJournals: Bool = false
    ) -> (sections: [MainScreenSection], items: [MainScreenSection: [MainScreenItem]]) {
        let sections: [MainScreenSection] = [.header, .careers, .programs, .academic, .services, .journal, .footer]
        let items: [MainScreenSection: [MainScreenItem]] = [
            .header: buildHeader(state: state, actions: actions),
            .careers: buildCareers(state: state, actions: actions),
            .programs: buildPrograms(state: state, actions: actions),
            .academic: buildAcademic(state: state, actions: actions),
            .services: buildServices(state: state, actions: actions),
            .journal: buildJournal(state: state, actions: actions, isLoading: isLoadingOnJournals),
            .footer: [.footerItem(.init(id: "footer", viewModel: MainScreenFooterCellViewModel()))]
        ]
        return (sections, items)
    }
    
    // MARK: - Private builders
    private func buildHeader(state: State, actions: Actions) -> [MainScreenItem] {
        let headerVM = MainScreenHeaderCellViewModel()
        let stepsVM = MainScreenStepsCellViewModel(
            showingAllItems: state.showingAllSteps,
            didTapChooseProfession: actions.didTapStepsProfession,
            didTapChooseENT: actions.didTapStepsENT,
            didTapChooseUniversity: actions.didTapStepsUniversity,
            didTapShowAllItems: actions.didTapShowAllSteps
        )
        return [
            .headerItem(.init(id: "header", viewModel: headerVM)),
            .stepsItem(.init(viewModel: stepsVM))
        ]
    }

    private func buildCareers(state: State, actions: Actions) -> [MainScreenItem] {
        let vm = MainScreenCareersCellViewModel(
            universities: state.universities,
            didTapUniversity: actions.didTapUniversity
        )
        return [.careersItem(.init(id: "careers", viewModel: vm))]
    }

    private func buildPrograms(state: State, actions: Actions) -> [MainScreenItem] {
        let vm = MainScreenProgramsCellViewModel(
            programs: state.programCategories,
            didTapShowAll: actions.didTapShowAllPrograms
        )
        return [.programItem(.init(id: "programs", viewModel: vm))]
    }

    private func buildAcademic(state: State, actions: Actions) -> [MainScreenItem] {
        var items: [MainScreenItem] = []

        let headerVM = MainScreenAcademicCellViewModel(
            selectedTab: state.selectedAcademicTab,
            didSelectTab: actions.didSelectAcademicTab
        )
        items.append(.academicItem(.init(id: "academic-header", viewModel: headerVM, version: state.selectedAcademicTab.rawValue)))

        switch state.selectedAcademicTab {
        case .universities:
            state.universities.prefix(3).forEach { university in
                let vm = CardWithImageCellViewModel(
                    imageURL: university.mainImageURL,
                    preTitle: "\(university.city.name) / \(university.programsCount) программ",
                    title: university.name, showsArrowRight: true
                ) { actions.didTapUniversity(university) }
                items.append(.cardWithImageItem(.init(item: university, prefix: "academic-uni", viewModel: vm)))
            }
            let vm = MainScreenAcademicShowAllCellViewModel(
                title: "Показать все наши вузы",
                didTapAction: actions.didTapShowAllUniversities
            )
            items.append(.academicShowAll(.init(viewModel:vm)))

        case .programs:
            state.programCategories.prefix(3).forEach { program in
                let vm = MainScreenAcademicProgramCellViewModel(program: program)
                items.append(.academicProgram(.init(item: program, prefix: "academic-program", viewModel: vm)))
            }
            let vm = MainScreenAcademicShowAllCellViewModel(
                title: "Показать все программы вузов",
                didTapAction: actions.didTapShowAllPrograms
            )
            items.append(.academicShowAll(.init(viewModel: vm)))

        case .professions:
            state.professions.prefix(3).forEach { profession in
                let vm = CardWithImageCellViewModel(
                    imageURL: profession.imageURL,
                    preTitle: "\(profession.programsCount) программ, \(profession.universitiesCount) вузов",
                    title: profession.name.ru, subtitle: profession.description.ru, showsArrowRight: true
                ) { actions.didTapProfession(profession) }
                items.append(.cardWithImageItem(.init(item: profession, prefix: "academic-profession-", viewModel: vm)))
            }
            let vm = MainScreenAcademicShowAllCellViewModel(
                title: "Показать все профессии вузов",
                didTapAction: actions.didTapShowAllProfessions
            )
            items.append(.academicShowAll(.init(viewModel: vm)))
        }

        return items
    }
    
    private func buildServices(state: State, actions: Actions) -> [MainScreenItem] {
        let vm = MainScreenServicesCellViewModel(
            didTapProfession: actions.didTapServicesProfession,
            didTapUniversity: actions.didTapServicesUniversity,
            didTapCalendar: actions.didTapServicesCalendar
        )
        return [.servicesItem(.init(id: "services", viewModel: vm))]
    }

    private func buildJournal(state: State, actions: Actions, isLoading: Bool) -> [MainScreenItem] {
        var items: [MainScreenItem] = []

        let headerVM = MainScreenJournalCellViewModel(
            selectedType: state.selectedJournalTab,
            allTypes: state.newsTypes,
            didSelectType: actions.didSelectJournalType
        )
        items.append(.journalItem(.init(id: "journal-header",viewModel: headerVM, version: state.selectedJournalTab?.id ?? -1)))

        guard !isLoading else {
            items.append(.loadingItem(.init(viewModel: LoadingCellViewModel())))
            return items
        }

        let newsToShow: [ECNews]
        if let selectedType = state.selectedJournalTab {
            newsToShow = state.newsByTypeId[selectedType.id] ?? []
        } else {
            newsToShow = state.allNews
        }
        
        guard !newsToShow.isEmpty else {
            let vm = NotFoundCellViewModel(
                systemImage: ImageConstants.SystemImages.questionMark.rawValue,
                title: "Ничего не найдено", subtitle: "Нет новостей в этой категории",
                horizontallySpaced: true
            )
            items.append(.notFoundItem(.init(viewModel: vm)))
            return items
        }
        newsToShow.forEach { news in
            let vm = CardWithImageCellViewModel(
                imageURL: news.previewImageURL, preTitle: news.newsType.name.ru,
                title: news.title.ru, subtitle: news.shortDescription.ru, showsArrowRight: true
            ) { actions.didTapArticle(news) }
            items.append(.cardWithImageItem(.init(item: news, prefix: "journal-news", viewModel: vm)))
        }
        
        let vm = UnderlineButtonCellViewModel(
            titleName: "Посмотреть все новости",
            titleSize: 14, titleColor: .darkGray,
            onTapAction: actions.didTapShowAllArticles
        )
        items.append(.underlineButtonItem(.init(id: "underlineButton", viewModel: vm)))

        return items
    }
}
