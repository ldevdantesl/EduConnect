//
//  MainScreenRouter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.02.2026
//

import UIKit

protocol MainScreenRouterProtocol {
    func openSidebar()
    func openAccount()
    func goBack()
    func navigateToUniversities()
    func navigateToProfessions()
    func navigateToPrograms()
    func navigateToUniversity(university: ECUniversity)
    func navigateToProfession(profession: ECProfession)
    func navigateToAllArticles()
    func routeToArticleDetails(article: ECNews)
    func routeToProgramCategory(category: ECProgramCategory)
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenVC?
    private let appRouter: AppRoutingProtocol
    
    init(appRouter: AppRoutingProtocol) {
        self.appRouter = appRouter
    }
    
    func openSidebar() {
        appRouter.openSidebar()
    }
    
    func openAccount() {
        appRouter.routeToAccount()
    }
    
    func goBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToUniversity(university: ECUniversity) {
        let vc = UniversityInfoScreenAssembler.assemble(appRouter: appRouter, university: university)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPrograms() {
        appRouter.diContainer.sidebarService.switchTo(tab: .programs)
    }
    
    func navigateToProfessions() {
        appRouter.diContainer.sidebarService.switchTo(tab: .professions)
    }
    
    func navigateToUniversities() {
        appRouter.diContainer.sidebarService.switchTo(tab: .universities)
    }
    
    func navigateToAllArticles() {
        let vc = ArticlesScreenAssembler.assemble(appRouter: appRouter)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToArticleDetails(article: ECNews) {
        let vc = ArticleDetailsScreenAssembler.assemble(appRouter: appRouter, article: article)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToProfession(profession: ECProfession) {
        let vc = ProfessionDetailsScreenAssembler.assemble(appRouter: appRouter, professionID: profession.id)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func routeToProgramCategory(category: ECProgramCategory) {
        let vc = ProgramsByCategoryScreenAssembler.assemble(appRouter: appRouter, category: category)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
