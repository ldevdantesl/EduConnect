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
    
    // MARK: - PROPERTIES
    private let sectionStore = ECDiffableSectionStore<ProgramDetailsSection>()

    // MARK: - VIEW PROPERTIES
    private lazy var headerView: ECHeaderView = {
        let vm = ECHeaderViewModel { [weak self] in self?.presenter?.didTapAccount() }
        didTapImage: { [weak self] in self?.presenter?.didTapAppLogo() }
        didTapBack: { [weak self] in self?.presenter?.didTapBack() }
        let header = ECHeaderView()
        header.configure(vm: vm)
        return header
    }()
    
    private lazy var collectionContainer: DiffableCollectionViewContainer = {
        let layout = ProgramDetailsLayoutFactory.make(sectionStore: sectionStore)
        let cv = DiffableCollectionViewContainer<ProgramDetailsSection, ProgramDetailsItem>(layout: layout)
        cv.registerCell(ProgramDetailsHeaderCell.self, reuseID: ProgramDetailsHeaderCell.identifier)
        cv.registerCell(ProgramDetailsUniversityCardCell.self, reuseID: ProgramDetailsUniversityCardCell.identifier)
        cv.registerCell(ProgramDetailsAboutCell.self, reuseID: ProgramDetailsAboutCell.identifier)
        cv.registerCell(DashedProgramCell.self, reuseID: DashedProgramCell.identifier)
        cv.registerCell(CardWithImageCell.self, reuseID: CardWithImageCell.identifier)
        cv.registerCell(SectionHeaderCell.self, reuseID: SectionHeaderCell.identifier)
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramDetailsHeaderCell.identifier, for: indexPath) as? ProgramDetailsHeaderCell
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
                
            case .aboutItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramDetailsAboutCell.identifier, for: indexPath) as? ProgramDetailsAboutCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .programItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DashedProgramCell.identifier, for: indexPath) as? DashedProgramCell
                cell?.configure(withVM: item.viewModel)
                return cell
                
            case .universityItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramDetailsUniversityCardCell.identifier, for: indexPath) as? ProgramDetailsUniversityCardCell
                cell?.configure(withVM: item.viewModel)
                return cell
            }
        }
    }
}

extension ProgramDetailsScreenVC: ProgramDetailsScreenViewProtocol {
    func applySnapshot(sections: [ProgramDetailsSection], itemsBySection: [ProgramDetailsSection : [ProgramDetailsItem]]) {
        sectionStore.update(sections)
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
