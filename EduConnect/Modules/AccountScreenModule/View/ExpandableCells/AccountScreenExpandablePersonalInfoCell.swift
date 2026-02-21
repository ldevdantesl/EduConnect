//
//  HomeScreenApplicationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 16.01.2026.
//

import UIKit
import SnapKit

final class AccountScreenExpandablePersonalInfoCellViewModel: ExpandableCellViewModel {
    var cellIdentifier: String = AccountScreenExpandablePersonalInfoCell.identifier
    var isExpanded: Bool
    let profile: Profile?
    let didTapExpand: (() -> Void)?
    let didTapSave: ((String?, String?, String?) -> Void)?
    
    init(
        profile: Profile?, isExpanded: Bool = false,
        didTapExpand: (() -> Void)? = nil, didTapSave: ((String?, String?, String?) -> Void)? = nil
    ) {
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
        self.didTapSave = didTapSave
        self.profile = profile
    }
}

final class AccountScreenExpandablePersonalInfoCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenExpandablePersonalInfoCellViewModel?
    private var expandableHeightConstraint: Constraint?
    private var isEditing: Bool = false
    
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
        label.text = ConstantLocalizedStrings.Account.Expandable.PersonalInfo.title
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.PersonalInfo.name
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let nameField: ECTextField = {
        let field = ECTextField(
            placeHolder: ConstantLocalizedStrings.Account.Expandable.PersonalInfo.name,
            showsBorder: false
        )
        field.isEnabled = false
        return field
    }()
    
    private let surnameLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.PersonalInfo.surname
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let surnameField: ECTextField = {
        let field = ECTextField(
            placeHolder: ConstantLocalizedStrings.Account.Expandable.PersonalInfo.surname,
            showsBorder: false
        )
        field.isEnabled = false
        return field
    }()
    
    private let patronymicLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.PersonalInfo.patronymic
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let patronymicField: ECTextField = {
        let field = ECTextField(
            placeHolder: ConstantLocalizedStrings.Account.Expandable.PersonalInfo.patronymic,
            showsBorder: false
        )
        field.isEnabled = false
        return field
    }()
    
    private lazy var editButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.edit)
        button.setAction { [weak self] in
            guard let self = self else { return }
            self.didTapEdit()
        }
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
        guard let vm = vm as? AccountScreenExpandablePersonalInfoCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
        guard let profile = vm.profile else { return }
        nameField.text = profile.name
        surnameField.text = profile.surname
        patronymicField.text = profile.patronymic
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
    
    private func expandCell() {
        expandableHeightConstraint?.deactivate()
        expandImageView.image = UIImage(systemName: Constants.chevronUpImage)
        layoutIfNeeded()
    }

    private func collapseCell() {
        expandableHeightConstraint?.activate()
        expandImageView.image = UIImage(systemName: Constants.chevronDownImage)
        layoutIfNeeded()
    }
    
    private func didTapEdit() {
        if !isEditing {
            editButton.reconfigure(text: ConstantLocalizedStrings.Common.save)
            nameField.reconfigure(showsBorder: true)
            nameField.isEnabled = true
            surnameField.reconfigure(showsBorder: true)
            surnameField.isEnabled = true
            patronymicField.reconfigure(showsBorder: true)
            patronymicField.isEnabled = true
        } else {
            editButton.reconfigure(text: ConstantLocalizedStrings.Common.edit)
            nameField.reconfigure(showsBorder: false)
            nameField.isEnabled = false
            surnameField.reconfigure(showsBorder: false)
            surnameField.isEnabled = false
            patronymicField.reconfigure(showsBorder: false)
            patronymicField.isEnabled = false
            self.viewModel?.didTapSave?(nameField.text, surnameField.text, patronymicField.text)
        }
        isEditing.toggle()
    }
    
    @objc private func expandTapped() {
        viewModel?.didTapExpand?()
    }
}
