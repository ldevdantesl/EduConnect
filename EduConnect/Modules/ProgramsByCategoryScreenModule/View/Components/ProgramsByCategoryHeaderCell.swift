//
//  ProgramsByCategoryHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.03.2026.
//

import UIKit
import SnapKit

struct ProgramsByCategoryHeaderCellViewModel {
    let totalPrograms: Int
    let totalUnis: Int
    let programCategory: ECProgramCategory
}

final class ProgramsByCategoryHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 190.0
        static let imageHeight = 250.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramsByCategoryHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.programsScreenHeaderImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.5
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let unisTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let programsTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [programsTotalLabel, unisTotalLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 20
        return stack
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
    public func configure(withVM vm: ProgramsByCategoryHeaderCellViewModel) {
        self.viewModel = vm
        self.titleLabel.text = vm.programCategory.name.toCurrentLanguage()
        self.programsTotalLabel.text = "\(vm.totalPrograms.description)\n\(ConstantLocalizedStrings.Words.programPlural)"
        self.unisTotalLabel.text = "\(vm.totalUnis.description)\n\(ConstantLocalizedStrings.Words.universityPlural)"
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = Constants.contentViewBackground
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(Constants.imageWidth)
            $0.height.equalTo(Constants.imageHeight)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        containerView.addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(hStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.lessThanOrEqualToSuperview().offset(-Constants.bigSpacing)
        }
    }
}
