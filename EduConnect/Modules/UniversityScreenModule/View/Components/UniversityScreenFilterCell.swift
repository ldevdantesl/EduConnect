//
//  UniversityScreenFilterCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenFilterCellViewModel {
    var currentFilters: UniversityFilters
    var searchText: String?
    var didTapChances: (() -> Void)?
    var didTapCity: (() -> Void)?
    var didTapSearch: ((String) -> Void)?
    var didTapFilters: (() -> Void)?
}

final class UniversityScreenFilterCell: UICollectionViewCell {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityScreenFilterCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var searchField: ECSearchField = {
        let field = ECSearchField(placeholder: ConstantLocalizedStrings.Common.browse)
        field.setAction { [weak self] in self?.viewModel?.didTapSearch?($0) }
        return field
    }()
    
    private lazy var filtersButton: ECButton = {
        let button = ECButton()
        button.configure(text: ConstantLocalizedStrings.Common.filter, backgroundColor: .systemBackground, textColor: .blue)
        button.setAction { [weak self] in self?.viewModel?.didTapFilters?() }
        button.borderColor = .blue
        button.borderWidth = 2
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
    func configure(withVM vm: UniversityScreenFilterCellViewModel) {
        self.viewModel = vm
        
        if let searchText = vm.searchText {
            self.searchField.text = searchText
        }

        if vm.currentFilters.appliedCount > 0 {
            filtersButton.reconfigure(text: "\(ConstantLocalizedStrings.University.Filter.addedFilters) \(vm.currentFilters.appliedCount)", backgroundColor: .systemBlue, textColor: .white)
            filtersButton.borderWidth = 0
        } else {
            filtersButton.reconfigure(text: ConstantLocalizedStrings.University.Filter.filter, backgroundColor: .systemBackground, textColor: .blue)
            filtersButton.borderColor = .blue
            filtersButton.borderWidth = 2
        }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(searchField)
        searchField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(filtersButton)
        filtersButton.snp.makeConstraints {
            $0.top.equalTo(searchField.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalTo(SharedConstants.buttonHeight)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
    }
}
