//
//  DashedProgramCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.03.2026.
//

import UIKit
import SnapKit
import Kingfisher

struct DashedProgramCellViewModel {
    let program: ECProgram
    let didTapAction: (() -> Void)?
    
    init(program: ECProgram, didTapAction: (() -> Void)? = nil) {
        self.program = program
        self.didTapAction = didTapAction
    }
}

final class DashedProgramCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let imageSize = 50.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: DashedProgramCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let container: ECDashedBorderView = {
        let view = ECDashedBorderView()
        view.cornerRadius = 15
        view.contentView.backgroundColor = .white
        view.showShadow = true
        return view
    }()
    
    private let universityImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    private let uniNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = ECFont.font(.semiBold, size: 14)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let programNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = ECFont.font(.semiBold, size: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let budgetPlacesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = ECFont.font(.medium, size: 14)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let paidPlacesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.font = ECFont.font(.medium, size: 14)
        label.adjustsFontForContentSizeCategory = true
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
    public func configure(withVM vm: DashedProgramCellViewModel) {
        self.viewModel = vm
        self.container.setAction(action: vm.didTapAction)
        
        if let url = URL(string: vm.program.university.logoURL) {
            self.universityImage.kf.setImage(with: url, placeholder: ImageConstants.appLogo.image)
        }
        
        self.uniNameLabel.text = vm.program.university.name.toCurrentLanguage()
        self.programNameLabel.text = vm.program.name.toCurrentLanguage()
        self.budgetPlacesLabel.text = "\(vm.program.budgetPlaces.description) Бюджетных мест"
        self.paidPlacesLabel.text = "\(vm.program.paidPlaces.description) Платных мест"
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        self.contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        container.contentView.addSubview(universityImage)
        universityImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Constants.imageSize)
        }
        
        container.contentView.addSubview(uniNameLabel)
        uniNameLabel.snp.makeConstraints {
            $0.top.equalTo(universityImage.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        container.contentView.addSubview(programNameLabel)
        programNameLabel.snp.makeConstraints {
            $0.top.equalTo(uniNameLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        container.contentView.addSubview(budgetPlacesLabel)
        budgetPlacesLabel.snp.makeConstraints {
            $0.top.equalTo(programNameLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        container.contentView.addSubview(paidPlacesLabel)
        paidPlacesLabel.snp.makeConstraints {
            $0.top.equalTo(budgetPlacesLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
