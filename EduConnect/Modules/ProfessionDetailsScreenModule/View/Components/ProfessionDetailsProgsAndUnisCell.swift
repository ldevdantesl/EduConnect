//
//  ProfessionScreenProgsAndUnisCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 25.02.2026.
//

import UIKit
import SnapKit

struct ProfessionDetailsProgsAndUnisCellViewModel {
    let profession: ECProfession
    let didTapPrograms: (() -> Void)?
    let didTapUniversities: (() -> Void)?
    
    init(profession: ECProfession, didTapPrograms: (() -> Void)? = nil, didTapUniversities: (() -> Void)? = nil) {
        self.profession = profession
        self.didTapPrograms = didTapPrograms
        self.didTapUniversities = didTapUniversities
    }
}

final class ProfessionDetailsProgsAndUnisCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
        static let cornerRadius = 60.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionDetailsProgsAndUnisCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let programsButton: ECDashedBorderButton = {
        let button = ECDashedBorderButton()
        button.titleText = ConstantLocalizedStrings.Profession.programs
        button.titleFont = ECFont.font(.semiBold, size: 14)
        button.titleColor = .white
        button.subtitleFont = ECFont.font(.medium, size: 14)
        button.subtitleColor = .white
        button.image = ImageConstants.professionProgramsImage.image
        button.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let unisButton: ECDashedBorderButton = {
        let button = ECDashedBorderButton()
        button.titleText = ConstantLocalizedStrings.Profession.unis
        button.titleFont = ECFont.font(.semiBold, size: 14)
        button.titleColor = .white
        button.subtitleFont = ECFont.font(.medium, size: 14)
        button.subtitleColor = .white
        button.image = ImageConstants.professionUnisImage.image
        button.cornerRadius = Constants.cornerRadius
        return button
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
    func configure(withVM vm: ProfessionDetailsProgsAndUnisCellViewModel) {
        self.viewModel = vm
        self.unisButton.subtitleText = vm.profession.universitiesCount.description
        self.programsButton.subtitleText = vm.profession.programsCount.description
        self.unisButton.setAction(action: vm.didTapUniversities)
        self.programsButton.setAction(action: vm.didTapPrograms)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(programsButton)
        programsButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(unisButton)
        unisButton.snp.makeConstraints {
            $0.top.equalTo(programsButton.snp.bottom).offset(Constants.hSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
