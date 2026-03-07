//
//  ArticlesScreenSegmentedCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.03.2026.
//

import UIKit
import SnapKit

struct ArticlesScreenSegmentedCellViewModel {
    let selectedType: ECNewsType?
    let allTypes: [ECNewsType]
    var didSelectType: ((ECNewsType?) -> Void)?
    
    init(selectedType: ECNewsType?, allTypes: [ECNewsType], didSelectType: ((ECNewsType?) -> Void)? = nil) {
        self.selectedType = selectedType
        self.allTypes = allTypes
        self.didSelectType = didSelectType
    }
}

final class ArticlesScreenSegmentedCell: UICollectionViewCell {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 12.0
        static let bigSpacing = 20.0
        static let tabHeight = 36.0
        static let allTabTag = -1
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ArticlesScreenSegmentedCellViewModel?
    private var tabButtons: [UIButton] = []
    
    // MARK: - VIEW PROPERTIES
    private let tabsScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private let tabsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 8
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
        clearTabs()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: ArticlesScreenSegmentedCellViewModel) {
        self.viewModel = vm
        setupTabs(types: vm.allTypes)
        updateTabSelection(selectedType: vm.selectedType)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(tabsScrollView)
        tabsScrollView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.tabHeight).priority(.high)
            $0.bottom.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        tabsScrollView.addSubview(tabsStack)
        tabsStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.height.equalToSuperview()
        }
    }
    
    private func setupTabs(types: [ECNewsType]) {
        clearTabs()
        
        let allButton = makeTabButton(title: "Все", tag: Constants.allTabTag)
        tabButtons.append(allButton)
        tabsStack.addArrangedSubview(allButton)
        
        types.enumerated().forEach { index, type in
            let button = makeTabButton(title: type.name.ru, tag: index)
            tabButtons.append(button)
            tabsStack.addArrangedSubview(button)
        }
    }
    
    private func clearTabs() {
        tabButtons.forEach { $0.removeFromSuperview() }
        tabButtons.removeAll()
    }
    
    private func makeTabButton(title: String, tag: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 10, bottom: 8, trailing: 10)
        config.attributedTitle = AttributedString(title)
        config.attributedTitle?.font = ECFont.font(.medium, size: 16)
        config.attributedTitle?.foregroundColor = .systemBlue
        
        let button = UIButton()
        button.configuration = config
        button.titleLabel?.numberOfLines = 1
        button.tag = tag
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultLow, for: .horizontal)
        button.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return button
    }
    
    private func updateTabSelection(selectedType: ECNewsType?) {
        tabButtons.forEach { button in
            let isSelected: Bool
            
            if button.tag == Constants.allTabTag {
                isSelected = selectedType == nil
            } else if let type = viewModel?.allTypes[safe: button.tag] {
                isSelected = type.id == selectedType?.id
            } else {
                isSelected = false
            }
            
            button.backgroundColor = isSelected ? UIColor.systemBlue : .clear
            button.configuration?.attributedTitle?.foregroundColor = isSelected ? UIColor.white : UIColor.systemGray
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func tabTapped(_ sender: UIButton) {
        if sender.tag == Constants.allTabTag {
            viewModel?.didSelectType?(nil)
        } else if let type = viewModel?.allTypes[safe: sender.tag] {
            viewModel?.didSelectType?(type)
        }
    }
}
