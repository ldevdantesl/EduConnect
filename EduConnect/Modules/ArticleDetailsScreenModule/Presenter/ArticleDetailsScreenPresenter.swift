//
//  ArticleDetailsScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit

protocol ArticleDetailsScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAccount()
    func didTapAppLogo()
    func didTapBack()
    func didReceiveRelatedNews(_ news: [ECNews])
    func didReceiveError(error: any Error)
}

final class ArticleDetailsScreenPresenter {
    // MARK: - VIPER
    weak var view: ArticleDetailsScreenViewProtocol?
    var router: ArticleDetailsScreenRouterProtocol
    var interactor: ArticleDetailsScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private let article: ECNews
    private var related: [ECNews] = []

    init(interactor: ArticleDetailsScreenInteractorProtocol, router: ArticleDetailsScreenRouterProtocol, article: ECNews, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
        self.article = article
    }
    
    private func applySnapshot() {
        let headerVM = ArticleDetailsHeaderCellViewModel(article: article)
        let plainTextVM = PlainTextCellViewModel(text: article.description.ru, horizontallySpaced: true)
        let relatedHeaderVM = SectionHeaderCellViewModel(title: "Читай также", titleSize: 20, titleAlignment: .center)
        let universityCardVM = ArticleDetailsUniversityCardCellViewModel(newsType: article.newsType, university: article.university) { [weak self] in
            self?.router.routeToUniversity(universityID: $0)
        }
        
        let relatedItems: [ArticleDetailsItem]
        if !related.isEmpty {
            relatedItems = related.map { news in
                let vm = CardWithImageCellViewModel(
                    imageURL: news.previewImageURL, preTitle: news.newsType.name.ru,
                    title: news.title.ru, subtitle: news.shortDescription.ru, showsArrowRight: true
                ) { [weak self] in self?.router.routeToAnotherNews(news: news) }
                return ArticleDetailsItem.cardWithImageItem(.init(item: news, prefix: "article-", viewModel: vm))
            }
        } else {
            relatedItems = [.loadingItem(.init(viewModel: LoadingCellViewModel()))]
        }
        
        view?.applySnapshot(
            sections: [.header, .body, .related],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .body : [
                    .universityItem(.init(id: "university-card", viewModel: universityCardVM)),
                    .plainTextItem(.init(id: "description", viewModel: plainTextVM)),
                    .sectionHeaderItem(.init(id: "related-header", viewModel: relatedHeaderVM))
                ],
                .related : relatedItems
            ]
        )
    }
}

extension ArticleDetailsScreenPresenter: ArticleDetailsScreenPresenterProtocol {
    func viewDidLoad() {
        applySnapshot()
        interactor.getRelated(article: article)
    }
    
    func didTapAccount() {
        router.openAccount()
    }
    
    func didTapAppLogo() {
        router.routeToMain()
    }
    
    func didTapBack() {
        router.goBack()
    }
    
    func didReceiveRelatedNews(_ news: [ECNews]) {
        self.related = news
        applySnapshot()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.view?.showError(userError: userError)
    }
}
