//
//  ProfessionDetailsScreenVC.swift
//  Super easy dev
//
//  Created by Buzurg Rakhimzoda on 25.02.2026
//

import UIKit
import SnapKit

protocol ProfessionDetailsScreenViewProtocol: AnyObject {
    func applySnapshot(sections: [ProfessionDetailsSection], itemsBySection: [ProfessionDetailsSection : [ProfessionDetailsItem]])
    
    func showPopup(_ popUp: PopUpView)
    func dismissPopup()
    
    func showError(error: UserFacingError)
    func showLoading()
    func hideLoading()
}

final class ProfessionDetailsScreenVC: UIViewController {

    // MARK: - VIPER
    var presenter: ProfessionDetailsScreenPresenterProtocol?
    
    // MARK: - PROPERTIES
    private var popUpView: PopUpView?
    
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
        let cv = DiffableCollectionViewContainer<ProfessionDetailsSection, ProfessionDetailsItem>(
            layout: ProfessionScreenLayoutFactory.make()
        )
        cv.registerCell(ProfessionDetailsHeaderCell.self, reuseID: ProfessionDetailsHeaderCell.identifier)
        cv.registerCell(ProfessionDetailsProgsAndUnisCell.self, reuseID: ProfessionDetailsProgsAndUnisCell.identifier)
        cv.registerCell(ProfessionDetailsAboutCell.self, reuseID: ProfessionDetailsAboutCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
        cv.registerCell(UnderlineButtonCell.self, reuseID: UnderlineButtonCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
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
            case .headerItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfessionDetailsHeaderCell.identifier, for: indexPath) as? ProfessionDetailsHeaderCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .progsAndUnisItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfessionDetailsProgsAndUnisCell.identifier, for: indexPath) as? ProfessionDetailsProgsAndUnisCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .aboutItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfessionDetailsAboutCell.identifier, for: indexPath) as? ProfessionDetailsAboutCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .underlineItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UnderlineButtonCell.identifier, for: indexPath) as? UnderlineButtonCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .sectionHeaderItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionHeaderCell.identifier, for: indexPath) as? SectionHeaderCell
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

extension ProfessionDetailsScreenVC: ProfessionDetailsScreenViewProtocol {
    func applySnapshot(sections: [ProfessionDetailsSection], itemsBySection: [ProfessionDetailsSection : [ProfessionDetailsItem]]) {
        collectionContainer.applySnapshot(sections: sections, itemsBySection: itemsBySection)
    }
    
    func showPopup(_ popUp: PopUpView) {
        self.popUpView = popUp
        popUp.show(in: view)
    }
    
    func dismissPopup() {
        popUpView?.dismiss()
        self.popUpView = nil
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
