//
//  HomeScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 9.01.2026
//

import UIKit
import SnapKit

protocol HomeScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [HomeSection], itemsBySection: [HomeSection : [HomeItem]])
    func reconfigureItems(items: [HomeItem])
}

final class HomeScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: HomeScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private let headerView = ECHeaderView()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<HomeSection, HomeItem>(
            layout: HomeLayoutFactory.make()
        )
        cv.registerCell(HomeScreenUniversityCell.self, reuseID: HomeScreenUniversityCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
        cv.registerCell(HomeScreenExpandablePersonalInfoCell.self, reuseID: HomeScreenExpandablePersonalInfoCell.identifier)
        cv.registerSupplementary(
            HomeScreenSegmentedReusableMenu.self,
            kind: UICollectionView.elementKindSectionHeader,
            reuseID: HomeScreenSegmentedReusableMenu.reuseID
        )
        return cv
    }()

    // MARK: - LIFE CYCLE
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? SectionHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .university(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? HomeScreenUniversityCell
                cell?.configure(withVM: item.viewModel)
                return cell
            case .expandableCell(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath)
                (cell as? ConfigurableCellProtocol)?.configure(withVM: item.viewModel)
                return cell
            case .banner: fatalError("Not implemented")
            }
        }
        
        collectionContainer.setSupplementaryViewProvider { [weak self] collectionView, kind, indexPath in
            guard let self = self else { return nil }
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HomeScreenSegmentedReusableMenu.reuseID,
                for: indexPath
            ) as? HomeScreenSegmentedReusableMenu else { return nil }
            guard let vm = self.presenter?.headerMenuViewModel else { return header }
            header.configure(withVM: vm)
            return header
        }
    }
}

extension HomeScreenVC: HomeScreenViewProtocol {
    func applySnapshot(sections: [HomeSection], itemsBySection: [HomeSection : [HomeItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [HomeItem]) {
        collectionContainer.reconfigureItems(items)
    }
}
