//
//  ProfessionScreenSearchCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.02.2026.
//

import UIKit
import SnapKit

struct ProfessionScreenSearchCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = ProfessionScreenSearchCell.identifier
    var searchText: String?
    var didTapSearch: ((String) -> Void)?
    var didTapSort: (() -> Void)?
    
    init(searchText: String? = nil, didTapSearch: ((String) -> Void)? = nil, didTapSort: (() -> Void)? = nil) {
        self.searchText = searchText
        self.didTapSearch = didTapSearch
        self.didTapSort = didTapSort
    }
}

final class ProfessionScreenSearchCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let hSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: ProfessionScreenSearchCellViewModel?
    
    // MARK: - VIEW PROPERTIES
    private lazy var searchField: ECSearchField = {
        let field = ECSearchField(placeholder: "Search")
        field.setAction { [weak self] in self?.viewModel?.didTapSearch?($0) }
        return field
    }()
    
    private lazy var sortButton: ECButton = {
        let button = ECButton()
        button.configure(text: "Сортировка", backgroundColor: .systemBackground, textColor: .blue)
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
        guard let vm = vm as? ProfessionScreenSearchCellViewModel else {
            print("❌ Wrong VM type: \(type(of: vm))")
            return
        }
        print("✅ ProfessionScreenSearchCell configured, didTapSearch is \(vm.didTapSearch == nil ? "nil" : "set")")
    
        self.viewModel = vm
        
        if let searchText = vm.searchText {
            self.searchField.text = searchText
        }
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
}
