//
//  UniversityInfoAboutCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.02.2026.
//

import UIKit
import SnapKit

struct UniversityInfoScreenAboutCellViewModel {
    let university: ECUniversity
    let didTapProgram: (() -> Void)?
    let didTapProfession: (() -> Void)?
    let didTapFaculties: (() -> Void)?
    
    init(
        university: ECUniversity,
        didTapProgram: (() -> Void)? = nil,
        didTapProfession: (() -> Void)? = nil,
        didTapFaculties: (() -> Void)? = nil
    ) {
        self.university = university
        self.didTapProgram = didTapProgram
        self.didTapProfession = didTapProfession
        self.didTapFaculties = didTapFaculties
    }
}

final class UniversityInfoScreenAboutCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 15.0
        static let bigSpacing = 20.0
        static let imageSize = 24.0
        static let itemSpacing = 12.0
        static let columnSpacing = 30.0
        static let buttonsHeight = 120
        static let buttonsCornerRadius = 60.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityInfoScreenAboutCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let aboutTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Об Университете"
        label.font = ECFont.font(.bold, size: 20)
        label.textColor = .label
        return label
    }()
    
    private let featuresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.itemSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private let programsButton: ECDashedBorderButton = {
        let button = ECDashedBorderButton()
        button.titleText = "Программы"
        button.cornerRadius = Constants.buttonsCornerRadius
        button.titleFont = ECFont.font(.semiBold, size: 14)
        button.subtitleFont = ECFont.font(.semiBold, size: 14)
        button.image = ImageConstants.programsImage.image
        return button
    }()
    
    private let professionsButton: ECDashedBorderButton = {
        let button = ECDashedBorderButton()
        button.titleText = "Профессии"
        button.cornerRadius = Constants.buttonsCornerRadius
        button.titleFont = ECFont.font(.semiBold, size: 14)
        button.subtitleFont = ECFont.font(.semiBold, size: 14)
        button.image = ImageConstants.professionsImage.image
        return button
    }()
    
    private let articlesButton: ECDashedBorderButton = {
        let button = ECDashedBorderButton()
        button.titleText = "Факультеты"
        button.cornerRadius = Constants.buttonsCornerRadius
        button.titleFont = ECFont.font(.semiBold, size: 14)
        button.subtitleFont = ECFont.font(.semiBold, size: 14)
        button.image = ImageConstants.articlesImage.image
        return button
    }()
    
    private let aboutUniversityLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.regular, size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .systemGray3
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        featuresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: UniversityInfoScreenAboutCellViewModel) {
        self.viewModel = vm
        configureFeatures()
        programsButton.subtitleText = "(\(vm.university.programsCount))"
        professionsButton.subtitleText = "(\(vm.university.professions.count))"
        articlesButton.subtitleText = "(\(vm.university.facultiesCount))"
        aboutUniversityLabel.text = vm.university.description
        programsButton.setAction(action: vm.didTapProgram)
        professionsButton.setAction(action: vm.didTapProfession)
        articlesButton.setAction(action: vm.didTapFaculties)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(aboutTitleLabel)
        aboutTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(featuresStack)
        featuresStack.snp.makeConstraints {
            $0.top.equalTo(aboutTitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(programsButton)
        programsButton.snp.makeConstraints {
            $0.top.equalTo(featuresStack.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.height.equalTo(Constants.buttonsHeight)
        }
        
        contentView.addSubview(professionsButton)
        professionsButton.snp.makeConstraints {
            $0.top.equalTo(programsButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.height.equalTo(Constants.buttonsHeight)
        }
        
        contentView.addSubview(articlesButton)
        articlesButton.snp.makeConstraints {
            $0.top.equalTo(professionsButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.height.equalTo(Constants.buttonsHeight)
        }
        
        contentView.addSubview(aboutUniversityLabel)
        aboutUniversityLabel.snp.makeConstraints {
            $0.top.equalTo(articlesButton.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
    
    private func configureFeatures() {
        guard let uni = viewModel?.university else { return }
        
        featuresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var features: [String] = []
        features.append(uni.universityTypeName)
        
        if uni.hasDormitory {
            features.append("Общежитие")
        }
        
        if uni.hasMilitaryDepartment {
            features.append("Воен. уч. центр")
        }
        
       
        let chunkedFeatures = features.chunked(into: 2)
        
        for row in chunkedFeatures {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = Constants.columnSpacing
            rowStack.distribution = .fillEqually
            
            for feature in row {
                let itemView = createFeatureItem(text: feature)
                rowStack.addArrangedSubview(itemView)
            }
            
            if row.count == 1 {
                let spacer = UIView()
                rowStack.addArrangedSubview(spacer)
            }
            
            featuresStack.addArrangedSubview(rowStack)
            rowStack.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }
    
    private func createFeatureItem(text: String) -> UIView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.alignment = .leading
        
        let imageView = UIImageView()
        imageView.image = ImageConstants.checkmarkIconBlue.image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.size.equalTo(Constants.imageSize) }
        
        let label = UILabel()
        label.text = text
        label.font = ECFont.font(.medium, size: 16)
        label.textColor = .label
        label.numberOfLines = 1
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(label)
        
        return container
    }
}
