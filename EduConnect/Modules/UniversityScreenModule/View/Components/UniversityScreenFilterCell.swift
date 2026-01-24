//
//  UniversityScreenFilterCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenFilterCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "UniversityScreenFilterCell"
    var didTapChances: (() -> Void)?
    var didTapCity: (() -> Void)?
    var didTapSearch: ((String) -> Void)?
    var didTapFilters: (() -> Void)?
}

final class UniversityScreenFilterCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: UniversityScreenFilterCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var chancesButton: ECButton = {
        let button = ECButton()
        button.configure(text: "Оценить шансы", backgroundColor: UIColor.hex("#427FF6"))
        button.setAction { [weak self] in self?.viewModel?.didTapChances?() }
        return button
    }()
    
    private lazy var chooseCityButton: ECButton = {
        let button = ECButton()
        button.configure(text: "Выбрать город", backgroundColor: UIColor.hex("#333399"))
        button.setAction { [weak self] in self?.viewModel?.didTapCity?() }
        return button
    }()
    
    private lazy var searchField: ECSearchField = {
        let field = ECSearchField(placeholder: "Search")
        field.setAction { [weak self] in self?.viewModel?.didTapSearch?($0) }
        return field
    }()
    
    private lazy var filtersButton: ECButton = {
        let button = ECButton()
        button.configure(text: "Фильтр", backgroundColor: .systemBackground, textColor: .blue)
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
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityScreenFilterCellViewModel else { return }
        self.viewModel = vm
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(chancesButton)
        chancesButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.trailing.equalToSuperview().multipliedBy(0.5)
            $0.height.equalTo(SharedConstants.buttonHeight)
        }
        
        contentView.addSubview(chooseCityButton)
        chooseCityButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(chancesButton.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.height.equalTo(SharedConstants.buttonHeight)
        }
        
        contentView.addSubview(searchField)
        searchField.snp.makeConstraints {
            $0.top.equalTo(chancesButton.snp.bottom).offset(Constants.spacing)
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
