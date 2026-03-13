//
//  ProgramDetailsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 13.03.2026
//

import UIKit
import SnapKit

protocol ProgramDetailsScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ProgramDetailsSection], itemsBySection: [ProgramDetailsSection : [ProgramDetailsItem]])
    func showError(error: UserFacingError)
    func showLoading()
    func hideLoading()
}

final class ProgramDetailsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProgramDetailsScreenPresenterProtocol?

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
        let cv = DiffableCollectionViewContainer<ProgramDetailsSection, ProgramDetailsItem>(
            layout: ProgramDetailsLayoutFactory.make()
        )
        cv.registerCell(NotFoundCell.self, reuseID: NotFoundCell.identifier)
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
            }
        }
    }
}

extension ProgramDetailsScreenVC: ProgramDetailsScreenViewProtocol {
    func applySnapshot(sections: [ProgramDetailsSection], itemsBySection: [ProgramDetailsSection : [ProgramDetailsItem]]) {
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
