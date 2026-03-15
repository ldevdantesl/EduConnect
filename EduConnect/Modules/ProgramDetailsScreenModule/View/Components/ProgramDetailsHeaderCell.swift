//
//  ProgramDetailsHeaderCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.03.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct ProgramDetailsHeaderCellViewModel {
    let programDetails: ECProgramDetails
    let university: ECUniversity
}

final class ProgramDetailsHeaderCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let imageHeight = SharedConstants.screenHeight * 0.3
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramDetailsHeaderCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    private let budgetPlacesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let paidPlacesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let priceInYearLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let freePlacesLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = .systemGray4
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = ECFont.font(.bold, size: 22)
        label.textColor = .white
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = ECFont.font(.semiBold, size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var firstHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [budgetPlacesLabel, paidPlacesLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 10
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var secondHStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [priceInYearLabel, freePlacesLabel])
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 10
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
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: ProgramDetailsHeaderCellViewModel) {
        self.viewModel = vm
        
        if let url = URL(string: vm.university.mainImageURL) {
            self.backgroundImageView.kf.setImage(with: url, placeholder: ImageConstants.appLogo.image)
        }
        
        self.budgetPlacesLabel.text = "\(vm.programDetails.budgetPlaces)\nБюджетных мест"
        self.paidPlacesLabel.text = "\(vm.programDetails.paidPlaces)\nПлатных мест"
        self.priceInYearLabel.text = "\(ECNumberFormatter.toDecimalFromString(number: vm.programDetails.price))\nТенге в год"
        self.freePlacesLabel.text = "\(vm.programDetails.freePlaces)\nСвободных мест"
        
        self.titleLabel.text = vm.programDetails.name.toCurrentLanguage()
        self.subtitleLabel.text = vm.programDetails.programCategory.name.toCurrentLanguage()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.imageHeight).priority(.high)
            $0.bottom.equalToSuperview()
        }
        
        backgroundImageView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerView.addSubview(firstHStack)
        firstHStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(secondHStack)
        secondHStack.snp.makeConstraints {
            $0.top.equalTo(firstHStack.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(secondHStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        containerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.bigSpacing)
        }
    }
}
