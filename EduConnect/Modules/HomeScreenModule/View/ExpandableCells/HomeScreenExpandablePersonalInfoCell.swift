//
//  HomeScreenApplicationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.01.2026.
//

import UIKit
import SnapKit

final class HomeScreenExpandablePersonalInfoCellViewModel: ExpandableCellViewModel {
    var cellIdentifier: String = "HomeScreenExpandablePersonalInfoCell"
    var isExpanded: Bool
    let didTapExpand: (() -> Void)?
    
    init(isExpanded: Bool = false, didTapExpand: (() -> Void)? = nil) {
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
    }
}

final class HomeScreenExpandablePersonalInfoCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: HomeScreenExpandablePersonalInfoCellViewModel?
    
    private var expandableHeightConstraint: Constraint?
    
    // MARK: - VIEW PROPERTIES
    private let headerContainer: UIView = {
        let container = UIView()
        container.backgroundColor = .systemGray6
        return container
    }()
    
    private let expandableContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        return view
    }()
    
    private let expandImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .systemBlue
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal information"
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let nameField: ECTextField = {
        let field = ECTextField(placeHolder: "YourName", showsBorder: false)
        field.isEnabled = false
        return field
    }()
    
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Surname"
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let surnameField: ECTextField = {
        let field = ECTextField(placeHolder: "Surname", showsBorder: false)
        field.isEnabled = false
        return field
    }()
    
    private let patronymicLabel: UILabel = {
        let label = UILabel()
        label.text = "Patronymic"
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let patronymicField: ECTextField = {
        let field = ECTextField(placeHolder: "patronymic", showsBorder: false)
        field.isEnabled = false
        return field
    }()
    
    private let editButton: ECButton = ECButton(text: "Edit")
    
    // MARK: - LIFECYCLE
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
        contentView.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        contentView.layer.cornerRadius = 10
        
        headerContainer.layer.borderWidth = 1
        headerContainer.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        headerContainer.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collapseCell()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? HomeScreenExpandablePersonalInfoCellViewModel else { return }
        self.viewModel = vm
        if vm.isExpanded { expandCell() }
        else { collapseCell() }
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandTapped))
        headerContainer.addGestureRecognizer(tap)

        contentView.addSubview(headerContainer)
        headerContainer.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        headerContainer.addSubview(personalInfoLabel)
        personalInfoLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
            $0.leading.equalToSuperview().inset(Constants.spacing)
        }

        headerContainer.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.centerY.equalTo(personalInfoLabel)
            $0.trailing.equalToSuperview().inset(Constants.spacing)
            $0.size.equalTo(Constants.expandImageSize)
        }

        contentView.addSubview(expandableContainer)
        expandableContainer.snp.makeConstraints {
            $0.top.equalTo(headerContainer.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview()
            expandableHeightConstraint = $0.height.equalTo(0).priority(.required).constraint
        }
        
        expandableContainer.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(nameField)
        nameField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(surnameLabel)
        surnameLabel.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(surnameField)
        surnameField.snp.makeConstraints {
            $0.top.equalTo(surnameLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(patronymicLabel)
        patronymicLabel.snp.makeConstraints {
            $0.top.equalTo(surnameField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(patronymicField)
        patronymicField.snp.makeConstraints {
            $0.top.equalTo(patronymicLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.top.equalTo(patronymicField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing).priority(.high)
        }
    }
    
    func expandCell() {
        expandableHeightConstraint?.deactivate()
        expandImageView.image = UIImage(systemName: Constants.chevronUpImage)
        layoutIfNeeded()
    }

    func collapseCell() {
        expandableHeightConstraint?.activate()
        expandImageView.image = UIImage(systemName: Constants.chevronDownImage)
        layoutIfNeeded()
    }
    
    @objc private func expandTapped() {
        viewModel?.didTapExpand?()
    }
}
