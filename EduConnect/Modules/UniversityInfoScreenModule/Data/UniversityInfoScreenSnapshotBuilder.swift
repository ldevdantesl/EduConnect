//
//  UniversityInfoScreenSnapshotBuilder.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.02.2026.
//

import UIKit

struct UniversityInfoScreenSnapshotBuilder {
    
    struct Actions {
        let didTapAboutFaculty: () -> Void
        let didTapAboutProgram: () -> Void
        let didTapAboutProfession: () -> Void
        let didTapApply: () -> Void
        let didTapRemoveApplication: () -> Void
        let didTapProfession: (Int) -> Void
    }
    
    func build(
        university: ECUniversity,
        applied: Bool,
        actions: Actions
    ) -> (sections: [UniversityInfoScreenSection], items: [UniversityInfoScreenSection: [UniversityInfoScreenItem]]) {
        let sections: [UniversityInfoScreenSection] = [.header, .main, .contacts, .faculties, .programs, .professions]
        let items: [UniversityInfoScreenSection: [UniversityInfoScreenItem]] = [
            .header: buildHeader(university: university),
            .main: buildMain(university: university, actions: actions),
            .contacts: [buildContacts(university: university, applied: applied, actions: actions)],
            .faculties: buildFaculties(university: university),
            .programs: buildPrograms(university: university),
            .professions: buildProfessions(university: university, actions: actions),
        ]
        return (sections, items)
    }
    
    func buildContacts(university: ECUniversity, applied: Bool, actions: Actions) -> UniversityInfoScreenItem {
        let contactsVM = UniversityInfoScreenContactsCellViewModel(
            university: university,
            applied: applied,
            didTapApply: actions.didTapApply,
            didTapRemove: actions.didTapRemoveApplication
        )
        return .contactsItem(.init(id: "contacts-\(applied)", viewModel: contactsVM))
    }
    
    // MARK: - Private builders
    private func buildHeader(university: ECUniversity) -> [UniversityInfoScreenItem] {
        let vm = UniversityInfoScreenHeaderCellViewModel(university: university)
        return [.headerItem(.init(id: "header", viewModel: vm))]
    }
    
    private func buildMain(university: ECUniversity, actions: Actions) -> [UniversityInfoScreenItem] {
        let entScoresVM = UniversityInfoScreenAverageEntCellViewModel(entScores: university.entScores ?? [])
        let aboutVM = UniversityInfoScreenAboutCellViewModel(
            university: university,
            didTapProgram: actions.didTapAboutProgram,
            didTapProfession: actions.didTapAboutProfession,
            didTapNews: actions.didTapAboutFaculty
        )
        return [
            .averageENTScoreItem(.init(id: "averageENTCells", viewModel: entScoresVM)),
            .aboutItem(.init(id: "about", viewModel: aboutVM)),
        ]
    }
    
    private func buildFaculties(university: ECUniversity) -> [UniversityInfoScreenItem] {
        guard university.facultiesCount > 0 else { return [] }
        var items: [UniversityInfoScreenItem] = []
        let headerVM = SectionHeaderCellViewModel(title: "Факультеты", titleSize: 22, titleAlignment: .center)
        items.append(.sectionHeaderItem(.init(id: "facultiesHeader", viewModel: headerVM)))
        university.faculties.forEach {
            let vm = CardWithImageCellViewModel(imageURL: $0.imageURL, title: $0.name)
            items.append(.cardItem(.init(id: "faculty-\($0.id)", viewModel: vm)))
        }
        return items
    }
    
    private func buildPrograms(university: ECUniversity) -> [UniversityInfoScreenItem] {
        guard university.programsCount > 0 else { return [] }
        var items: [UniversityInfoScreenItem] = []
        let headerVM = SectionHeaderCellViewModel(title: "Программы образования", titleSize: 22, titleAlignment: .center)
        items.append(.sectionHeaderItem(.init(id: "programsHeader", viewModel: headerVM)))
        university.programs.forEach {
            let vm = CardWithImageCellViewModel(
                imageURL: university.logoURL,
                imageContentMode: .scaleAspectFit,
                title: $0.name,
                subtitle: "\($0.budgetPlaces) бюджет. мест, \($0.paidPlaces) платн. мест, \($0.studyTypeName) обучение"
            )
            items.append(.cardItem(.init(id: "program-\($0.id)", viewModel: vm)))
        }
        return items
    }
    
    private func buildProfessions(university: ECUniversity, actions: Actions) -> [UniversityInfoScreenItem] {
        guard university.professions.count > 0 else { return [] }
        var items: [UniversityInfoScreenItem] = []
        let headerVM = SectionHeaderCellViewModel(title: "Профессии", titleSize: 22, titleAlignment: .center)
        items.append(.sectionHeaderItem(.init(id: "professionsHeader", viewModel: headerVM)))
        university.professions.forEach { profession in
            let vm = CardWithImageCellViewModel(imageURL: profession.imageURL, title: profession.name) {
                actions.didTapProfession(profession.id)
            }
            items.append(.cardItem(.init(id: "profession-\(profession.id)", viewModel: vm)))
        }
        return items
    }
}
