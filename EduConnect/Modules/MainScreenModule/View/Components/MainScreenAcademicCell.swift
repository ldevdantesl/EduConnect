//
//  MainScreenAcademicCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 6.02.2026.
//

import UIKit
import SnapKit

struct MainScreenAcademicCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = MainScreenAcademicCell.identifier
    let selectedTab: AcademicTab
    var didSelectTab: ((AcademicTab) -> Void)?
    
    enum AcademicTab: Int, CaseIterable {
        case universities = 0
        case programs = 1
        case professions = 2
        
        var title: String {
            switch self {
            case .universities: return "Вузы"
            case .programs: return "Программы вузов"
            case .professions: return "Профессии вузов"
            }
        }
    }
}

final class MainScreenAcademicCell: UICollectionViewCell, ConfigurableCellProtocol {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let spacing = 12.0
        static let bigSpacing = 20.0
        static let tabHeight = 36.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: MainScreenAcademicCellViewModel?
    private var tabButtons: [UIButton] = []
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let text = "Высшие учебные\nзаведения Казахстана"
        let attributed = NSMutableAttributedString(
            string: text,
            attributes: [.font: ECFont.font(.bold, size: 24)]
        )
        if let range = text.range(of: "Казахстана") {
            let nsRange = NSRange(range, in: text)
            attributed.addAttributes([.font: ECFont.font(.regular, size: 20)], range: nsRange)
        }
        
        let label = UILabel()
        label.attributedText = attributed
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let tabsScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    private let tabsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTabs()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? MainScreenAcademicCellViewModel else { return }
        self.viewModel = vm
        updateTabSelection(selectedTab: vm.selectedTab)
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
        }
        
        contentView.addSubview(tabsScrollView)
        tabsScrollView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Constants.tabHeight)
            $0.bottom.equalToSuperview().inset(Constants.spacing)
        }
        
        tabsScrollView.addSubview(tabsStack)
        tabsStack.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.bigSpacing)
            $0.height.equalToSuperview()
        }
    }
    
    private func setupTabs() {
        MainScreenAcademicCellViewModel.AcademicTab.allCases.forEach { tab in
            let button = makeTabButton(title: tab.title, tag: tab.rawValue)
            tabButtons.append(button)
            tabsStack.addArrangedSubview(button)
        }
    }
    
    private func makeTabButton(title: String, tag: Int) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = ECFont.font(.medium, size: 14)
        button.configuration = config
        button.tag = tag
        button.layer.cornerRadius = Constants.tabHeight / 2
        button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
        return button
    }
    
    private func updateTabSelection(selectedTab: MainScreenAcademicCellViewModel.AcademicTab) {
        tabButtons.forEach { button in
            let isSelected = button.tag == selectedTab.rawValue
            button.backgroundColor = isSelected ? UIColor.purple : .clear
            button.setTitleColor(isSelected ? .white : .label, for: .normal)
            button.layer.borderWidth = isSelected ? 0 : 1
            button.layer.borderColor = isSelected ? nil : UIColor.systemGray4.cgColor
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func tabTapped(_ sender: UIButton) {
        guard let tab = MainScreenAcademicCellViewModel.AcademicTab(rawValue: sender.tag) else { return }
        viewModel?.didSelectTab?(tab)
    }
}
