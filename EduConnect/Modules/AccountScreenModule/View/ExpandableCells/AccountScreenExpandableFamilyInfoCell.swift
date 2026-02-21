//
//  HomeScreenExpandableFamilyInfoCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026.
//

import UIKit
import SnapKit

final class AccountScreenExpandableFamilyInfoCellViewModel: ExpandableCellViewModel {
    let cellIdentifier: String = AccountScreenExpandableFamilyInfoCell.identifier
    let profile: Profile
    var isExpanded: Bool
    let didTapExpand: (() -> Void)?
    let didTapSave: ((String?, String?) -> Void)?
    
    init(profile: Profile, isExpanded: Bool, didTapExpand: (() -> Void)? = nil, didTapSave: ((String?, String?) -> Void)? = nil) {
        self.profile = profile
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
        self.didTapSave = didTapSave
    }
}

final class AccountScreenExpandableFamilyInfoCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenExpandableFamilyInfoCellViewModel?
    private var expandableHeightConstraint: Constraint?
    private var isEditing: Bool = false
    
    // MARK: - VIEW PROPERTIES
    private var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private var expandableContainer: UIView = {
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
    
    private let familyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.FamilyInfo.title
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private let fathersPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Common.phoneNumber) (\(ConstantLocalizedStrings.Account.Expandable.FamilyInfo.father))"
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let fathersPhoneNumberField: ECTextField = {
        let field = ECTextField(placeHolder: "+52", showsBorder: false)
        field.keyboardType = .phonePad
        field.isEnabled = false
        return field
    }()
    
    private let momsPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Common.phoneNumber) (\(ConstantLocalizedStrings.Account.Expandable.FamilyInfo.mother))"
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let momsPhoneNumberField: ECTextField = {
        let field = ECTextField(placeHolder: "+52", showsBorder: false)
        field.keyboardType = .phonePad
        field.isEnabled = false
        return field
    }()
    
    private lazy var editButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.edit)
        button.setAction { [weak self] in
            guard let self = self else { return }
            self.didPressEditButton()
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
        guard let vm = vm as? AccountScreenExpandableFamilyInfoCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
        
        let father = vm.profile.familyContacts.indices.contains(0) ? vm.profile.familyContacts[0] : nil
        let mother = vm.profile.familyContacts.indices.contains(1) ? vm.profile.familyContacts[1] : nil

        fathersPhoneNumberField.text = father?.phoneNumber
        momsPhoneNumberField.text = mother?.phoneNumber
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapExpand))
        self.headerContainer.addGestureRecognizer(tap)
        
        contentView.addSubview(headerContainer)
        headerContainer.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        headerContainer.addSubview(familyInfoLabel)
        familyInfoLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        headerContainer.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.expandImageSize)
        }
        
        contentView.addSubview(expandableContainer)
        expandableContainer.snp.makeConstraints {
            $0.top.equalTo(headerContainer.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.bottom.equalToSuperview()
            expandableHeightConstraint = $0.height.equalTo(0).priority(.required).constraint
        }
        
        expandableContainer.addSubview(momsPhoneNumberLabel)
        momsPhoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        expandableContainer.addSubview(momsPhoneNumberField)
        momsPhoneNumberField.snp.makeConstraints {
            $0.top.equalTo(momsPhoneNumberLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(fathersPhoneNumberLabel)
        fathersPhoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(momsPhoneNumberField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        expandableContainer.addSubview(fathersPhoneNumberField)
        fathersPhoneNumberField.snp.makeConstraints {
            $0.top.equalTo(fathersPhoneNumberLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.top.equalTo(fathersPhoneNumberField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().inset(Constants.spacing)
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
    
    private func didPressEditButton() {
        if !isEditing {
            editButton.reconfigure(text: ConstantLocalizedStrings.Common.save)
            fathersPhoneNumberField.reconfigure(showsBorder: true)
            fathersPhoneNumberField.isEnabled = true
            momsPhoneNumberField.reconfigure(showsBorder: true)
            momsPhoneNumberField.isEnabled = true
        } else {
            self.viewModel?.didTapSave?(momsPhoneNumberField.text, fathersPhoneNumberField.text)
            editButton.reconfigure(text: ConstantLocalizedStrings.Common.edit)
            fathersPhoneNumberField.reconfigure(showsBorder: false)
            fathersPhoneNumberField.isEnabled = false
            momsPhoneNumberField.reconfigure(showsBorder: false)
            momsPhoneNumberField.isEnabled = false
        }
        isEditing.toggle()
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapExpand() {
        viewModel?.didTapExpand?()
    }
}
