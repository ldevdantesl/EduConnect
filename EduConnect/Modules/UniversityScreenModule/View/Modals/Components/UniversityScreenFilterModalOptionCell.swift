//
//  UniversityScreenFilterModalOptionCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 24.01.2026.
//

import UIKit
import SnapKit

struct UniversityScreenFilterModalOptionCellViewModel: CellViewModelProtocol {
    var cellIdentifier: String = "UniversityScreenFilterModalOptionCell"
    let filterType: UniversityFilterOption
    var selectedValue: String? = nil
    var subItems: [String] = []
    var onSelectOption: ((String) -> Void)?
}

final class UniversityScreenFilterModalOptionCell: UICollectionViewCell, ConfigurableCellProtocol {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 15.0
        static let imageSize = 20.0
    }
    
    // MARK: - Properties
    private var viewModel: UniversityScreenFilterModalOptionCellViewModel?
    
    // MARK: - Views
    private let menuButton: UIButton = {
        let button = UIButton()
        button.showsMenuAsPrimaryAction = true
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray4.cgColor
        contentView.layer.cornerRadius = 12
    }
    
    // MARK: - Public
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? UniversityScreenFilterModalOptionCellViewModel else { return }
        self.viewModel = vm
        
        if let selected = vm.selectedValue {
            contentView.backgroundColor = .systemBlue
            titleLabel.text = selected
            titleLabel.textColor = .white
            chevronImageView.tintColor = .white
        } else {
            contentView.backgroundColor = .systemBackground
            titleLabel.text = vm.filterType.title
            titleLabel.textColor = .label
            chevronImageView.tintColor = .systemGray
        }
    
        let actions = vm.subItems.map { item in
            UIAction(title: item) { [weak self] _ in
                self?.viewModel?.onSelectOption?(item)
            }
        }
        
        menuButton.configuration?.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        menuButton.menu = UIMenu(title: vm.filterType.title, children: actions)
    }
    
    // MARK: - Private
    private func setupUI() {
        contentView.clipsToBounds = true

        contentView.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.imageSize)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-Constants.spacing)
        }
    }
}
