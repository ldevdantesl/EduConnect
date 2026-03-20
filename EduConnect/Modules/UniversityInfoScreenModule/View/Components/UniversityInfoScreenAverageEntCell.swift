//
//  UniversityInfoScreenAverageEntCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 31.01.2026.
//

import UIKit
import SnapKit

struct UniversityInfoScreenAverageEntCellViewModel {
    var entScores: [ECUniversity.EntScores]
}

final class UniversityInfoScreenAverageEntCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 10.0
        static let bigSpacing = 20.0
        static let headerWidth = 100.0
        static let valueWidth = 70.0
        static let stackSpacing = 15.0
    }

    
    // MARK: - PROPERTIES
    private var scores: [ECUniversity.EntScores] = []
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.University.averageScoreENT
        label.font = ECFont.font(.bold, size: 20)
        label.textColor = .label
        return label
    }()
    
    private let tableScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let scrollContentView = UIView()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    private let yearsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fill
        stack.backgroundColor = .clear
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 10, left: 20, bottom: 10, right: 20)
        return stack
    }()

    private let budgetStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemGray6
        stack.axis = .horizontal
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        return stack
    }()

    private let contractStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemGray6
        stack.axis = .horizontal
        stack.spacing = Constants.stackSpacing
        stack.distribution = .fill
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
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
    func configure(withVM vm: UniversityInfoScreenAverageEntCellViewModel) {
        self.scores = vm.entScores.sorted { $0.year > $1.year }
        setupTableContent()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(tableScrollView)
        tableScrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        tableScrollView.addSubview(scrollContentView)
        scrollContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.greaterThanOrEqualToSuperview()
        }
        
        scrollContentView.addSubview(yearsStack)
        yearsStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        scrollContentView.addSubview(budgetStack)
        budgetStack.snp.makeConstraints {
            $0.top.equalTo(yearsStack.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
        
        scrollContentView.addSubview(separator)
        separator.snp.makeConstraints {
            $0.top.equalTo(budgetStack.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(2)
        }
        
        scrollContentView.addSubview(contractStack)
        contractStack.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupTableContent() {
        yearsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        budgetStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        contractStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let yearHeaderLabel = createTableLabel(text: "Год", isHeader: true)
        yearsStack.addArrangedSubview(yearHeaderLabel)
        
        let budgetHeaderLabel = createTableLabel(text: "Бюджет", isHeader: true)
        budgetStack.addArrangedSubview(budgetHeaderLabel)
        
        let contractHeaderLabel = createTableLabel(text: "Платное", isHeader: true)
        contractStack.addArrangedSubview(contractHeaderLabel)
        
        let yearSpacer = UIView()
        yearSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        yearsStack.addArrangedSubview(yearSpacer)
        
        let budgetSpacer = UIView()
        budgetSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        budgetStack.addArrangedSubview(budgetSpacer)
        
        let contractSpacer = UIView()
        contractSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contractStack.addArrangedSubview(contractSpacer)
        
        for (index, score) in scores.enumerated() {
            let isLast = index == scores.count - 1
            
            let yearLabel = createTableLabel(text: "\(score.year)", isLast: isLast)
            yearsStack.addArrangedSubview(yearLabel)
            
            let budgetLabel = createTableLabel(text: score.budgetScore, isLast: isLast)
            budgetStack.addArrangedSubview(budgetLabel)
            
            let contractLabel = createTableLabel(text: score.contractScore, isLast: isLast)
            contractStack.addArrangedSubview(contractLabel)
        }
    }

    private func createTableLabel(text: String, isHeader: Bool = false, isLast: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = ECFont.font(.medium, size: 16)
        label.numberOfLines = 1
        
        if isHeader {
            label.textColor = .black
            label.textAlignment = .left
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
        } else {
            label.textAlignment = .center
            label.snp.makeConstraints {
                $0.width.equalTo(Constants.valueWidth)
            }
            
            if isLast {
                label.textColor = .systemBlue
            } else {
                label.textColor = .darkGray
            }
        }
        
        return label
    }
}
