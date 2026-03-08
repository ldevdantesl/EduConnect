//
//  LoginScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 3.01.2026
//

import UIKit
import SnapKit

protocol LoginScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [LoginScreenSection], itemsBySection: [LoginScreenSection : [LoginScreenItem]])
    func showError(errorMessage: String)
    func scrollToNextItem()
    func scrollToPreviousItem()
    func showLoading()
    func hideLoading()
    func removeKeyboard()
}

final class LoginScreenVC: UIViewController {
    
    // MARK: - VIPER
    var presenter: LoginScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let collectionView = DiffableCollectionViewContainer<LoginScreenSection, LoginScreenItem>(layout: LoginScreenLayoutFactory.make())
        collectionView.registerCell(LoginScreenRegistrationCell.self, reuseID: LoginScreenRegistrationCell.identifier)
        collectionView.registerCell(LoginScreenConfirmRegistrationCell.self, reuseID: LoginScreenConfirmRegistrationCell.identifier)
        collectionView.registerCell(LoginScreenSetPasswordCell.self, reuseID: LoginScreenSetPasswordCell.identifier)
        collectionView.registerCell(LoginScreenCompleteRegistrationCell.self, reuseID: LoginScreenCompleteRegistrationCell.identifier)
        collectionView.registerCell(LoginScreenLoginCell.self, reuseID: LoginScreenLoginCell.identifier)
        collectionView.backgroundColor = .systemBlue
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
            case .loginItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginScreenLoginCell.identifier, for: indexPath) as? LoginScreenLoginCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .completeRegisterItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginScreenCompleteRegistrationCell.identifier, for: indexPath) as? LoginScreenCompleteRegistrationCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .registrationItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginScreenRegistrationCell.identifier, for: indexPath) as? LoginScreenRegistrationCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .setPasswordItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginScreenSetPasswordCell.identifier, for: indexPath) as? LoginScreenSetPasswordCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .confirmRegisterItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoginScreenConfirmRegistrationCell.identifier, for: indexPath) as? LoginScreenConfirmRegistrationCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .loadingItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.identifier, for: indexPath) as? LoadingCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension LoginScreenVC:LoginScreenViewProtocol {
    func applySnapshot(sections: [LoginScreenSection], itemsBySection: [LoginScreenSection : [LoginScreenItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func showError(errorMessage: String) {
        self.showToastedError(message: errorMessage)
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
