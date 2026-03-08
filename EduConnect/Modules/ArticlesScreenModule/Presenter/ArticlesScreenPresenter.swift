//
//  ArticlesScreenPresenter.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit

protocol ArticlesScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapAccount()
    func didTapAppLogo()
    func didTapBack()
    
    func didReceiveNewsTypes(types: [ECNewsType])
    func didReceiveNewsForType(response: PaginatedResponse<ECNews>, typeID: Int?)
    func didReceiveAllNews(response: PaginatedResponse<ECNews>)
    func didReceiveError(error: any Error)
}

final class ArticlesScreenPresenter {
    // MARK: - VIPER
    weak var view: ArticlesScreenViewProtocol?
    var router: ArticlesScreenRouterProtocol
    var interactor: ArticlesScreenInteractorProtocol
    
    // MARK: - PROPERTIES
    private let errorService: ErrorServiceProtocol
    private let dispatchGroup = DispatchGroup()
    
    private var selectedNewsType: ECNewsType? = nil
    private var newsTypes: [ECNewsType] = []
    private var newsByTypeId: [Int?: [ECNews]] = [:]
    
    private var paginationByTypeId: [Int?: (currentPage: Int, totalPages: Int)] = [:]
    
    init(interactor: ArticlesScreenInteractorProtocol, router: ArticlesScreenRouterProtocol, errorService: ErrorServiceProtocol) {
        self.interactor = interactor
        self.router = router
        self.errorService = errorService
    }
    
    private func applySnapshot() {
        let headerVM = ArticlesScreenHeaderCellViewModel()
        let segmentedVM = ArticlesScreenSegmentedCellViewModel(selectedType: selectedNewsType, allTypes: newsTypes) { [weak self] in
            self?.didSelectAnotherTab(tabType: $0)
        }
        
        let newsToShow: [ECNews] = newsByTypeId[selectedNewsType?.id] ?? []
        
        var items: [ArticlesScreenItem] = []
        if newsToShow.isEmpty {
            let vm = NotFoundCellViewModel(
                systemImage: ImageConstants.SystemImages.questionMark.rawValue,
                title: "Ничего не найдено", subtitle: "Нет новостей в этой категории",
                horizontallySpaced: true
            )
            items.append(.notFoundItem(.init(viewModel: vm)))
        } else {
            newsToShow.forEach { news in
                let vm = CardWithImageCellViewModel(
                    imageURL: news.previewImageURL, preTitle: news.newsType.name.ru,
                    title: news.title.ru, subtitle: news.shortDescription.ru, showsArrowRight: true
                ) { [weak self] in self?.router.routeToArticleDetails(article: news) }
                items.append(.cardWithImageItem(.init(item: news, prefix: "article-", viewModel: vm)))
            }
            
            let pagination = paginationByTypeId[selectedNewsType?.id] ?? (1, 1)
            let currentPage = pagination.currentPage
            let totalPages = pagination.totalPages
            
            if totalPages > 1 {
                let indicatorVM = PageIndicatorCellViewModel(totalPages: totalPages, currentPage: currentPage) { [weak self] in
                    guard let self = self else { return }
                    self.didPressPage(page: currentPage + 1)
                } didPressPage: { [weak self] in
                    self?.didPressPage(page: $0)
                }
                items.append(.pageIndicatorItem(.init(viewModel: indicatorVM)))
            }
        }
        
        view?.applySnapshot(
            sections: [.header, .segmentedControl, .news],
            itemsBySection: [
                .header : [.headerItem(.init(id: "header", viewModel: headerVM))],
                .segmentedControl : [
                    .segmentedItem(
                        .init(
                            id: "segmented-control",
                            viewModel: segmentedVM,
                            version: selectedNewsType?.id ?? -1
                        )
                    )
                ],
                .news : items
            ]
        )
    }
    
    private func applyLoadingSnapshot() {
        let loadingVM = LoadingCellViewModel()
        self.view?.replaceItems(in: .news, items: [.loadingItem(.init(viewModel: loadingVM))])
    }
    
    private func didPressPage(page: Int) {
        applyLoadingSnapshot()
        interactor.getNewsForType(typeID: selectedNewsType?.id, page: page)
    }
    
    private func didSelectAnotherTab(tabType: ECNewsType?) {
        guard tabType?.id != selectedNewsType?.id else { return }
        selectedNewsType = tabType
        
        if let news = newsByTypeId[tabType?.id], news.count > 0 {
            applySnapshot()
        } else {
            applyLoadingSnapshot()
            interactor.getNewsForType(typeID: tabType?.id, page: nil)
        }
    }
}

extension ArticlesScreenPresenter: ArticlesScreenPresenterProtocol {
    func viewDidLoad() {
        self.view?.showLoading()
        
        dispatchGroup.enter()
        interactor.getAllNews()
        
        dispatchGroup.enter()
        interactor.getNewsTypes()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.applySnapshot()
            self?.view?.hideLoading()
        }
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
    
    // MARK: - NEWS
    func didReceiveNewsTypes(types: [ECNewsType]) {
        self.newsTypes = types
        dispatchGroup.leave()
    }
    
    func didReceiveAllNews(response: PaginatedResponse<ECNews>) {
        self.newsByTypeId[nil] = response.data
        self.paginationByTypeId[nil] = (response.meta.currentPage, response.meta.lastPage)
        dispatchGroup.leave()
    }

    func didReceiveNewsForType(response: PaginatedResponse<ECNews>, typeID: Int?) {
        self.newsByTypeId[typeID] = response.data
        self.paginationByTypeId[typeID] = (response.meta.currentPage, response.meta.lastPage)
        applySnapshot()
    }
    
    func didReceiveError(error: any Error) {
        let userError = errorService.handle(error)
        self.dispatchGroup.leave()
        self.view?.showError(userError: userError)
        self.view?.hideLoading()
    }
}
