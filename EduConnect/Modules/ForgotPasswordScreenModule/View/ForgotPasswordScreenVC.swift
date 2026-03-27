//
//  ForgotPasswordScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 26.03.2026
//

import UIKit
import SnapKit

protocol ForgotPasswordScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ForgotPasswordSection], itemsBySection: [ForgotPasswordSection : [ForgotPasswordItem]])
    func showError(errorMessage: String)
    func showMessage(message: String)
    func scrollToNextItem()
    func scrollToPreviousItem()
    func showLoading()
    func hideLoading()
    func removeKeyboard()
}

final class ForgotPasswordScreenVC: UIViewController {

    var presenter: ForgotPasswordScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let layout = ForgotPasswordLayoutFactory.make()
        let collectionView = DiffableCollectionViewContainer<ForgotPasswordSection, ForgotPasswordItem>(layout: layout)
        collectionView.backgroundColor = .systemBlue
        collectionView.adjustsForKeyboard = true
        collectionView.registerCell(ForgotPasswordConfirmCodeCell.self, reuseID: ForgotPasswordConfirmCodeCell.identifier)
        collectionView.registerCell(ForgotPasswordTypeEmailCell.self, reuseID: ForgotPasswordTypeEmailCell.identifier)
        collectionView.registerCell(ForgotPasswordNewPasswordCell.self, reuseID: ForgotPasswordNewPasswordCell.identifier)
        collectionView.registerCell(ForgotPasswordBackToLoginCell.self, reuseID: ForgotPasswordBackToLoginCell.identifier)
        collectionView.collectionView.backgroundColor = .systemBlue
        collectionView.collectionView.isPagingEnabled = true
        collectionView.collectionView.isScrollEnabled = false
        collectionView.collectionView.bounces = false
        return collectionView
    }()
    
    // MARK: - FUNC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDataSource()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        self.view.addSubview(collectionContainer)
        collectionContainer.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        collectionContainer.configureDataSource { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .backToLoginItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForgotPasswordBackToLoginCell.identifier, for: indexPath)
                (cell as? ForgotPasswordBackToLoginCell)?.configure(withVM: item.viewModel)
                return cell
                
            case .newPasswordItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForgotPasswordNewPasswordCell.identifier, for: indexPath)
                (cell as? ForgotPasswordNewPasswordCell)?.configure(withVM: item.viewModel)
                return cell
                
            case .confirmCodeItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForgotPasswordConfirmCodeCell.identifier, for: indexPath)
                (cell as? ForgotPasswordConfirmCodeCell)?.configure(withVM: item.viewModel)
                return cell
            
            case .typeInEmailItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForgotPasswordTypeEmailCell.identifier, for: indexPath)
                (cell as? ForgotPasswordTypeEmailCell)?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension ForgotPasswordScreenVC: ForgotPasswordScreenViewProtocol {
    func applySnapshot(sections: [ForgotPasswordSection], itemsBySection: [ForgotPasswordSection : [ForgotPasswordItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func showError(errorMessage: String) {
        self.showToastedError(message: errorMessage)
    }
    
    func showMessage(message: String) {
        self.showToastedMessage(message: message)
    }
    
    func scrollToNextItem() {
        let collectionView = collectionContainer.collectionView

        guard
            let currentIndexPath = collectionView.indexPathsForVisibleItems
                .sorted().first
        else { return }

        let nextItem = currentIndexPath.item + 1
        let section = currentIndexPath.section

        guard nextItem < collectionView.numberOfItems(inSection: section) else { return }

        let nextIndexPath = IndexPath(item: nextItem, section: section)

        collectionView.scrollToItem(
            at: nextIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func scrollToPreviousItem() {
        let collectionView = collectionContainer.collectionView

        guard
            let currentIndexPath = collectionView.indexPathsForVisibleItems
                .sorted().first
        else { return }

        let prevItem = currentIndexPath.item - 1
        let section = currentIndexPath.section

        guard prevItem >= 0 else { return }

        let prevIndexPath = IndexPath(item: prevItem, section: section)

        collectionView.scrollToItem(
            at: prevIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func showLoading() {
        showHoverLoading()
    }
    
    func hideLoading() {
        hideHoverLoading()
    }
    
    func removeKeyboard() {
        self.view.endEditing(true)
    }
}
