//
//  ProfessionScreenSearchCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.02.2026.
//

import UIKit
import SnapKit

struct ProfessionScreenSearchCellViewModel {
    var searchText: String?
    var didTapSearch: ((String) -> Void)?
    var didTapSortOption: ((ProfessionSortOption?) -> Void)?
    
    init(searchText: String? = nil, didTapSearch: ((String) -> Void)? = nil, didTapSortOption: ((ProfessionSortOption?) -> Void)? = nil) {
        self.searchText = searchText
        self.didTapSearch = didTapSearch
        self.didTapSortOption = didTapSortOption
    }
}

final class ProfessionScreenSearchCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }

    // MARK: - PROPERTIES
    private var viewModel: ProfessionScreenSearchCellViewModel?

    // MARK: - VIEW PROPERTIES
    private lazy var searchField: ECSearchField = {
        let field = ECSearchField(placeholder: ConstantLocalizedStrings.Common.search)
        field.setAction { [weak self] in self?.viewModel?.didTapSearch?($0) }
        return field
    }()

    private let sortButton: UIButton = {
        var config = UIButton.Configuration.plain()

        var title = AttributedString(ConstantLocalizedStrings.Common.sort)
        title.font = ECFont.font(.bold, size: 16)
        title.foregroundColor = .blue

        config.attributedTitle = title
        config.background.strokeColor = .blue
        config.background.strokeWidth = 2
        config.background.cornerRadius = 12

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        return button
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
    func configure(withVM vm: ProfessionScreenSearchCellViewModel) {
        self.viewModel = vm
        print("configure called, didTapSortOption is \(vm.didTapSortOption != nil)")
        
        if let searchText = vm.searchText {
            self.searchField.text = searchText
        }
        
        sortButton.menu = buildSortMenu()
    }

    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(searchField)
        searchField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }

        contentView.addSubview(sortButton)
        sortButton.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }

    private func buildSortMenu() -> UIMenu {
        let didTapSortOption = viewModel?.didTapSortOption
        
        var actions: [UIAction] = []
        let nilAction = UIAction(title: "Любой") { [weak self] _ in
            guard let self else { return }
            var title = AttributedString(ConstantLocalizedStrings.Common.sort)
            title.font = ECFont.font(.bold, size: 16)
            title.foregroundColor = .blue
            
            self.sortButton.configuration?.attributedTitle = title
            self.sortButton.configuration?.background.backgroundColor = .systemBackground
            didTapSortOption?(nil)
        }
        actions.append(nilAction)
        
        let sortActions = ProfessionSortOption.allCases.map { option in
            UIAction(title: option.title) { [weak self] _ in
                guard let self else { return }
                var title = AttributedString(option.title)
                title.font = ECFont.font(.bold, size: 16)
                title.foregroundColor = .white
                
                self.sortButton.configuration?.attributedTitle = title
                self.sortButton.configuration?.background.backgroundColor = .systemBlue
                didTapSortOption?(option)
            }
        }
        actions.append(contentsOf: sortActions)
        return UIMenu(children: actions)
    }
}
