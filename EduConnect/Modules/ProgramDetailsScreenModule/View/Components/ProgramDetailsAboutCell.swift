//
//  ProgramDetailsAboutCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.03.2026.
//

import UIKit
import SnapKit

struct ProgramDetailsAboutCellViewModel {
    let details: ECProgramDetails
}

final class ProgramDetailsAboutCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProgramDetailsAboutCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        vStack.clearArrangedSubviews()
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(withVM vm: ProgramDetailsAboutCellViewModel) {
        self.viewModel = vm
        
        let name = makeHStack(name: ConstantLocalizedStrings.Words.title, value: vm.details.name.toCurrentLanguage())
        let category = makeHStack(name: ConstantLocalizedStrings.Words.category, value: vm.details.programCategory.name.toCurrentLanguage())
        let type = makeHStack(name: ConstantLocalizedStrings.Words.type, value: vm.details.typeName)
        let budget = makeHStack(name: ConstantLocalizedStrings.Words.budgetPlaces, value: vm.details.budgetPlaces.description)
        let paid = makeHStack(name: ConstantLocalizedStrings.Words.paidPlaces, value: vm.details.paidPlaces.description)
        let price = makeHStack(name: ConstantLocalizedStrings.Words.price, value: vm.details.price)
        
        [name, category, type, budget, paid, price].forEach { vStack.addArrangedSubview($0) }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
    }
    
    private func makeHStack(name: String, value: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 5
        
        let labelName = UILabel()
        labelName.text = name + ":"
        labelName.textColor = .black
        labelName.font = ECFont.font(.bold, size: 16)
        labelName.numberOfLines = 1
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .black
        valueLabel.font = ECFont.font(.medium, size: 16)
        valueLabel.adjustsFontForContentSizeCategory = true
        valueLabel.numberOfLines = 1
        
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(valueLabel)
        return stack
    }
}
