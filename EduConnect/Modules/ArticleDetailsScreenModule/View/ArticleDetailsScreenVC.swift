//
//  ArticleDetailsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 7.03.2026
//

import UIKit
import SnapKit

protocol ArticleDetailsScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ArticleDetailsSection], itemsBySection: [ArticleDetailsSection : [ArticleDetailsItem]])
    func replaceItems(in section: ArticleDetailsSection, items: [ArticleDetailsItem])
    func showError(userError: UserFacingError)
    func showLoading()
    func hideLoading()
}

final class ArticleDetailsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ArticleDetailsScreenPresenter?
    
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
        let layout = ArticlesDetailsLayoutFactory.make()
        let cv = DiffableCollectionViewContainer<ArticleDetailsSection, ArticleDetailsItem>(layout: layout)
        cv.registerCell(ArticleDetailsHeaderCell.self, reuseID: ArticleDetailsHeaderCell.identifier)
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
            case .headerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleDetailsHeaderCell.identifier, for: indexPath) as? ArticleDetailsHeaderCell
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

extension ArticleDetailsScreenVC: ArticleDetailsScreenViewProtocol {
    func applySnapshot(sections: [ArticleDetailsSection], itemsBySection: [ArticleDetailsSection : [ArticleDetailsItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func replaceItems(in section: ArticleDetailsSection, items: [ArticleDetailsItem]) {
        collectionContainer.replaceItems(in: section, with: items)
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
