//
//  HomeScreenExpandableEducationCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026.
//

import UIKit
import SnapKit

final class AccountScreenExpandableEducationCellViewModel: ExpandableCellViewModel {
    private(set) var cellIdentifier: String = AccountScreenExpandableEducationCell.identifier
    let profile: Profile
    var isExpanded: Bool
    let didTapExpand: (() -> Void)?
    let didTapSave: ((String?, String?, Double?) -> Void)?
    
    init(profile: Profile, isExpanded: Bool, didTapExpand: (() -> Void)? = nil, didTapSave: ((String?, String?, Double?) -> Void)? = nil) {
        self.profile = profile
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
        self.didTapSave = didTapSave
    }
}

final class AccountScreenExpandableEducationCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenExpandableEducationCellViewModel?
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
    
    private let educationLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Education.title
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private let schoolLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Education.school
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let schoolField: ECTextField = {
        let field = ECTextField(
            placeHolder: ConstantLocalizedStrings.Account.Expandable.Education.school,
            showsBorder: false
        )
        field.isEnabled = false
        return field
    }()
    
    private let finalClassLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Education.finalClass
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let finalClassField: ECTextField = {
        let field = ECTextField(
            placeHolder: ConstantLocalizedStrings.Account.Expandable.Education.finalClass,
            showsBorder: false
        )
        field.isEnabled = false
        return field
    }()
    
    private let averageLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.Education.averageScore
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let averageField: ECTextField = {
        let field = ECTextField(placeHolder: "20", showsBorder: false)
        field.keyboardType = .numberPad
        field.maximumCharacters = 3
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
        guard let vm = vm as? AccountScreenExpandableEducationCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
        schoolField.text = vm.profile.education.educationalInstitution
        finalClassField.text = vm.profile.education.educationClass
        averageField.text = vm.profile.education.averageScore
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandTapped))
        headerContainer.addGestureRecognizer(tap)

        contentView.addSubview(headerContainer)
        headerContainer.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        headerContainer.addSubview(educationLabel)
        educationLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(Constants.spacing)
            $0.leading.equalToSuperview().inset(Constants.spacing)
        }

        headerContainer.addSubview(expandImageView)
        expandImageView.snp.makeConstraints {
            $0.centerY.equalTo(educationLabel)
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
        
        expandableContainer.addSubview(schoolLabel)
        schoolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(schoolField)
        schoolField.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(finalClassLabel)
        finalClassLabel.snp.makeConstraints {
            $0.top.equalTo(schoolField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(finalClassField)
        finalClassField.snp.makeConstraints {
            $0.top.equalTo(finalClassLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }
        
        expandableContainer.addSubview(averageLabel)
        averageLabel.snp.makeConstraints {
            $0.top.equalTo(finalClassField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        expandableContainer.addSubview(averageField)
        averageField.snp.makeConstraints {
            $0.top.equalTo(averageLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.4)
        }
        
        expandableContainer.addSubview(editButton)
        editButton.snp.makeConstraints {
            $0.top.equalTo(averageField.snp.bottom).offset(Constants.spacing).priority(.high)
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
            schoolField.reconfigure(showsBorder: true)
            schoolField.isEnabled = true
            finalClassField.reconfigure(showsBorder: true)
            finalClassField.isEnabled = true
            averageField.reconfigure(showsBorder: true)
            averageField.isEnabled = true
        } else {
            editButton.reconfigure(text: ConstantLocalizedStrings.Common.edit)
            schoolField.reconfigure(showsBorder: false)
            schoolField.isEnabled = false
            finalClassField.reconfigure(showsBorder: false)
            finalClassField.isEnabled = false
            averageField.reconfigure(showsBorder: false)
            averageField.isEnabled = false
            self.viewModel?.didTapSave?(schoolField.text, finalClassField.text, Double(averageField.text ?? ""))
        }
        isEditing.toggle()
    }
    
    @objc private func expandTapped() {
        viewModel?.didTapExpand?()
    }
}
