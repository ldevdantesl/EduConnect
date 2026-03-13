//
//  ProgramsByCategoryScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit
import SnapKit

protocol ProgramsByCategoryScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ProgramsByCategorySection], itemsBySection: [ProgramsByCategorySection : [ProgramsByCategoryItem]])
    func showError(error: UserFacingError)
    func showLoading()
    func hideLoading()
}

final class ProgramsByCategoryScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProgramsByCategoryScreenPresenterProtocol?
    
    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapAccount() }
        didTapImage: { [weak self] in self?.presenter?.didTapAppLogo() }
        didTapBack: { [weak self] in self?.presenter?.didTapBack() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private let collectionContainer: DiffableCollectionViewContainer = {
        let cv = DiffableCollectionViewContainer<ProgramsByCategorySection, ProgramsByCategoryItem>(
            layout: ProgramsByCategoryLayoutFactory.make()
        )
        cv.registerCell(NotFoundCell.self, reuseID: NotFoundCell.identifier)
        cv.registerCell(ProgramsByCategoryHeaderCell.self, reuseID: ProgramsByCategoryHeaderCell.identifier)
        cv.resignsFirstResponderOnScroll = true
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
            case .notFoundItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotFoundCell.identifier, for: indexPath) as? NotFoundCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .headerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramsByCategoryHeaderCell.identifier, for: indexPath) as? ProgramsByCategoryHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension ProgramsByCategoryScreenVC: ProgramsByCategoryScreenViewProtocol {
    func applySnapshot(sections: [ProgramsByCategorySection], itemsBySection: [ProgramsByCategorySection : [ProgramsByCategoryItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func showError(error: UserFacingError) {
        self.showToastedError(userError: error)
    }
    
    func showLoading() {
        self.showHoverLoading()
    }
    
    func hideLoading() {
        self.hideHoverLoading()
    }
}
