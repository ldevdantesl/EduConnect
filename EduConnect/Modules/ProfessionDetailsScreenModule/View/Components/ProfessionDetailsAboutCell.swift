//
//  ProfessionDetailsAboutCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 1.03.2026.
//

import UIKit
import SnapKit

struct ProfessionDetailsAboutCellViewModel {
    let profession: ECProfession
}

final class ProfessionDetailsAboutCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionDetailsAboutCellViewModel?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 22)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private var aboutLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
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
    public func configure(withVM vm: ProfessionDetailsAboutCellViewModel) {
        self.viewModel = vm
        headerLabel.text = "О профессии \(vm.profession.name.toCurrentLanguage())"
        aboutLabel.text = vm.profession.description.toCurrentLanguage()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
        
        contentView.addSubview(aboutLabel)
        aboutLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
