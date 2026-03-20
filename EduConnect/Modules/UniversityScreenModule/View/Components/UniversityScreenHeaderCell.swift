//
//  UniversityScreenHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenHeaderCellViewModel {
    let totalUniversities: Int
    let totalCities: Int
    let totalBudgetSpaces: Int
    
    init(totalUniversities: Int = 1143, totalCities: Int = 285, totalBudgetSpaces: Int = 441343) {
        self.totalUniversities = totalUniversities
        self.totalCities = totalCities
        self.totalBudgetSpaces = totalBudgetSpaces
    }
}

final class UniversityScreenHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let contentViewBackground = UIColor.hex("#795CED")
        static let imageWidth = 240.0
        
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityScreenHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.universityScreenHeaderImage.image
        iv.contentMode = .scaleAspectFill
        iv.layer.opacity = 0.4
        return iv
    }()
    
    private let containerView: UIView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.University.Header.title
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.University.Header.subtitle
        label.font = ECFont.font(.regular, size: 17)
        label.textColor = .white
        return label
    }()
    
    private let universitiesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let citiesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let budgetSpacesTotalLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private lazy var totalsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [universitiesTotalLabel, citiesTotalLabel, budgetSpacesTotalLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
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
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = Constants.contentViewBackground
        contentView.addSubview(headerImageView)
        headerImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(Constants.imageWidth)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        containerView.addSubview(totalsStack)
        totalsStack.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(Constants.bigSpacing + Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.lessThanOrEqualToSuperview().offset(-Constants.bigSpacing)
        }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: UniversityScreenHeaderCellViewModel) {
        self.viewModel = vm
        self.universitiesTotalLabel.text = "\(vm.totalUniversities)\n\(ConstantLocalizedStrings.Words.universityPlural)"
        self.citiesTotalLabel.text = "\(vm.totalCities)\n\(ConstantLocalizedStrings.Words.cityPlural)"
        self.budgetSpacesTotalLabel.text = "\(vm.totalBudgetSpaces)\n\(ConstantLocalizedStrings.Words.budgetPlaces)"
    }
}
