//
//  UniversityScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 23.01.2026
//

import UIKit
import SnapKit

protocol UniversityScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [UniversityScreenSection], itemsBySection: [UniversityScreenSection : [UniversityScreenItem]])
    func reconfigureItems(items: [UniversityScreenItem])
}

final class UniversityScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: UniversityScreenPresenterProtocol?

    // MARK: - VIEW PROPERTIES
    private let headerView: ECHeaderView = ECHeaderView()
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<UniversityScreenSection, UniversityScreenItem>(
            layout: UniversityScreenLayoutFactory.make()
        )
        cv.registerCell(UniversityScreenHeaderCell.self, reuseID: UniversityScreenHeaderCell.identifier)
        cv.registerCell(UniversityCell.self, reuseID: UniversityCell.identifier)
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - LIFECYCLE
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewModel.cellIdentifier, for: indexPath) as? UniversityScreenHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
}

extension UniversityScreenVC: UniversityScreenViewProtocol {
    func applySnapshot(sections: [UniversityScreenSection], itemsBySection: [UniversityScreenSection : [UniversityScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func reconfigureItems(items: [UniversityScreenItem]) {
        collectionContainer.reconfigureItems(items)
    }
}
