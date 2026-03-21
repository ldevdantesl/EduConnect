//
//  MainScreenFooterCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import UIKit
import SnapKit

struct MainScreenFooterCellViewModel {
    let programsCount: Int
    let universitiesCount: Int
    let budgetPlacesCount: Int
}

final class MainScreenFooterCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let hugeSpacing = 30.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenFooterCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Main.Footer.title
        label.font = ECFont.font(.bold, size: 28)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private let statsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .top
        stack.spacing = 10
        return stack
    }()
    
    private let percentageTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Main.Footer.percentageLabel
        label.font = ECFont.font(.semiBold, size: 16)
        label.textColor = .systemGray
        return label
    }()
    
    private let percentageSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Main.Footer.percentageSubtitle
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Main.Footer.description
        label.font = ECFont.font(.regular, size: 14)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
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
        statsStack.arrangedSubviews.forEach { $0.removeFromSuperview(); statsStack.removeArrangedSubview($0) }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: MainScreenFooterCellViewModel) {
        self.viewModel = vm
        let programsStatView = makeStatView(number: vm.programsCount, subtitle: ConstantLocalizedStrings.Main.Footer.programs)
        let privateUnisStatView = makeStatView(number: vm.universitiesCount, subtitle: ConstantLocalizedStrings.Main.Footer.privateUnis)
        let budgetPlacesCount = makeStatView(number: vm.budgetPlacesCount, subtitle: ConstantLocalizedStrings.Main.Footer.budgetPlaces)
        statsStack.addArrangedSubview(programsStatView)
        statsStack.addArrangedSubview(privateUnisStatView)
        statsStack.addArrangedSubview(budgetPlacesCount)
    }
    
    // MARK: - PRIVATE FUNC
    private func makeStatView(number: Int, subtitle: String) -> UIView {
        let container = UIView()

        let numberLabel = UILabel()
        numberLabel.text = "\(number)"
        numberLabel.font = ECFont.font(.bold, size: 18)
        numberLabel.textColor = .label

        let titleLabel = UILabel()
        titleLabel.text = subtitle
        titleLabel.font = ECFont.font(.regular, size: 14)
        titleLabel.textColor = .secondaryLabel
        titleLabel.numberOfLines = 0

        container.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        return container
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.hugeSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(statsStack)
        statsStack.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(percentageTitleLabel)
        percentageTitleLabel.snp.makeConstraints {
            $0.top.equalTo(statsStack.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(percentageSubtitleLabel)
        percentageSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(percentageTitleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(percentageSubtitleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
