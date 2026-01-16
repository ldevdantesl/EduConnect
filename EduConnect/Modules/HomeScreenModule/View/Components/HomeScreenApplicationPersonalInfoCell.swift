//
//  HomeScreenApplicationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.01.2026.
//

import UIKit
import SnapKit

struct HomeScreenApplicationPersonalInfoCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "HomeScreenApplicationPersonalInfoCell"
    let didSave: ((String, String, String) -> Void)?
    
    init(didSave: ((String, String, String) -> Void)? = nil) {
        self.didSave = didSave
    }
}

final class HomeScreenApplicationPersonalInfoCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants { }
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenApplicationPersonalInfoCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private var personalInfoSectionHeader: UILabel = {
        let label = UILabel()
        label.text = "Personal information"
        label.font = ECFont.font(.semiBold, size: 14)
        return label
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? HomeScreenApplicationPersonalInfoCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() { }
    
    // MARK: - OBJC FUNC
}
