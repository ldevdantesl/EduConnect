//
//  ArticlesScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 5.03.2026
//

import UIKit
import SnapKit

protocol ArticlesScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ArticlesScreenSection], itemsBySection: [ArticlesScreenSection : [ArticlesScreenItem]])
    func reconfigureItems(items: [ArticlesScreenItem])
    func replaceItems(in section: ArticlesScreenSection, items: [ArticlesScreenItem])
    func reloadSection(section: ArticlesScreenSection)
    func showError(userError: UserFacingError)
    func scrollToTop(onCompletion: (() -> Void)?)
    func showLoading()
    func hideLoading()
}

final class ArticlesScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ArticlesScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel(
            didTapAccount: { [weak self] in self?.presenter?.didTapAccount() },
            didTapImage: { [weak self] in self?.presenter?.didTapAppLogo() },
            didTapBack: { [weak self] in self?.presenter?.didTapBack() }
        )
        let header = ECHeaderView(viewModel: vm)
        return header
    }()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let layout = ArticlesScreenLayoutFactory.make()
        let cv = DiffableCollectionViewContainer<ArticlesScreenSection, ArticlesScreenItem>(layout: layout)
        cv.registerCell(ArticlesScreenHeaderCell.self, reuseID: ArticlesScreenHeaderCell.identifier)
        cv.registerCell(ArticlesScreenSegmentedCell.self, reuseID: ArticlesScreenSegmentedCell.identifier)
        cv.registerCell(LoadingCell.self, reuseID: LoadingCell.identifier)
        cv.registerCell(PageIndicatorCell.self, reuseID: PageIndicatorCell.identifier)
        cv.registerCell(NotFoundCell.self, reuseID: NotFoundCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureCollectionView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(self.headerHeight)
        }
        
        self.view.addSubview(collectionContainer)
        collectionContainer.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.headerHeight)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func configureCollectionView() {
        collectionContainer.configureDataSource { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .headerItem:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesScreenHeaderCell.identifier, for: indexPath) as? ArticlesScreenHeaderCell
                return cell
                
            case .segmentedItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesScreenSegmentedCell.identifier, for: indexPath) as? ArticlesScreenSegmentedCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .pageIndicatorItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageIndicatorCell.identifier, for: indexPath) as? PageIndicatorCell
                cell?.configure(withVM: item.viewModel)
                return cell
                            
            case .notFoundItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotFoundCell.identifier, for: indexPath) as? NotFoundCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .loadingItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .cardWithImageItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardWithImageCell.identifier, for: indexPath) as? CardWithImageCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension ArticlesScreenVC: ArticlesScreenViewProtocol {
    func applySnapshot(sections: [ArticlesScreenSection], itemsBySection: [ArticlesScreenSection : [ArticlesScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func replaceItems(in section: ArticlesScreenSection, items: [ArticlesScreenItem]) {
        collectionContainer.replaceItems(in: section, with: items)
    }
    
    func reconfigureItems(items: [ArticlesScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
    
    func reloadSection(section: ArticlesScreenSection) {
        collectionContainer.reloadSection(section: section)
    }
    
    func scrollToTop(onCompletion: (() -> Void)?) {
        collectionContainer.scrollToTop(completion: onCompletion)
    }
    
    func showError(userError: UserFacingError) {
        self.showToastedError(userError: userError)
    }
    
    func showLoading() {
        self.showHoverLoading()
    }
    
    func hideLoading() {
        self.hideHoverLoading()
    }
}
