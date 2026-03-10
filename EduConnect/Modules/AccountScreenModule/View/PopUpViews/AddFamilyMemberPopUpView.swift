//
//  AddFamilyMemberPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import UIKit
import SnapKit

struct AddFamilyMemberPopUpViewModel: PopUpViewModel {
    var familyMembers: [ECFamilyMember]
    var onClose: (() -> Void)?
    var didAddNewFamilyMember: ((Int?, String?, String?) -> Void)?
    
    init(familyMembers: [ECFamilyMember], onClose: (() -> Void)? = nil, didAddNewFamilyMember: ((Int?, String?, String?) -> Void)? = nil) {
        self.familyMembers = familyMembers
        self.onClose = onClose
        self.didAddNewFamilyMember = didAddNewFamilyMember
    }
}

final class AddFamilyMemberPopUpView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let xmarkImage = "xmark"
        static let xmarkButtonSize = 20.0
        static let smallSpacing = 5.0
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: AddFamilyMemberPopUpViewModel
    private var selectedFamily: ECFamilyMember?
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.FamilyInfo.popupTitle
        label.font = ECFont.font(.bold, size: 16)
        return label
    }()
    
    private lazy var xmarkButton: ECIconButton = {
        let vm = ECIconButtonVM(systemImage: Constants.xmarkImage) { [weak self] in self?.didTapCloseButton() }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let familyLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Account.Expandable.FamilyInfo.contact) *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Account.Words.name) *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let nameField: ECTextField = {
        let field = ECTextField(placeHolder: "\(ConstantLocalizedStrings.Account.Words.name)")
        return field
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "\(ConstantLocalizedStrings.Common.phoneNumber) *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let phoneField: ECTextField = {
        let field = ECTextField(placeHolder: "\(ConstantLocalizedStrings.Common.phoneNumber)")
        field.keyboardType = .numberPad
        return field
    }()
    
    private let topDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        return view
    }()
    
    private let bottomDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.label.withAlphaComponent(0.8)
        return view
    }()
    
    private lazy var cancelButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.cancel, backgroundColor: .white, textColor: .blue)
        button.borderColor = .blue
        button.borderWidth = 1
        button.setAction { [weak self] in self?.didTapCloseButton() }
        return button
    }()
    
    private lazy var addButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.add)
        button.setAction { [weak self] in
            guard let self = self else { return }
            let id = selectedFamily?.id
            let name = nameField.text
            let phoneNumber = phoneField.text
            self.viewModel.didAddNewFamilyMember?(id, name, phoneNumber)
        }
        return button
    }()
    
    private lazy var familyMenu: UIMenu = {
        let actions = viewModel.familyMembers.map { family in
            UIAction(title: family.name.toCurrentLanguage()) { [weak self] _ in
                self?.selectedFamily = family
                var title = AttributedString(family.name.toCurrentLanguage())
                title.font = ECFont.font(.semiBold, size: 14)
                title.foregroundColor = .label
                self?.chooseFamilyButton.configuration?.attributedTitle = title
            }
        }
        return UIMenu(title: ConstantLocalizedStrings.Account.Expandable.FamilyInfo.contact, children: actions)
    }()
    
    private lazy var chooseFamilyButton: UIButton = {
        var title = AttributedString(ConstantLocalizedStrings.Account.Expandable.FamilyInfo.title)
        title.font = ECFont.font(.semiBold, size: 14)
        title.foregroundColor = .label
        
        var config = UIButton.Configuration.plain()
        config.attributedTitle = title
        config.titleAlignment = .leading
        
        config.baseForegroundColor = .label
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let button = UIButton(configuration: config)
        button.contentHorizontalAlignment = .leading
        button.showsMenuAsPrimaryAction = true
        button.menu = familyMenu
        return button
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: AddFamilyMemberPopUpViewModel) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chooseFamilyButton.layer.borderColor = UIColor.black.cgColor
        chooseFamilyButton.layer.cornerRadius = 10
        chooseFamilyButton.layer.borderWidth = 1
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
        }
        
        contentView.addSubview(xmarkButton)
        xmarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.bigSpacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.size.equalTo(Constants.xmarkButtonSize)
        }
        
        contentView.addSubview(topDividerView)
        topDividerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        contentView.addSubview(familyLabel)
        familyLabel.snp.makeConstraints {
            $0.top.equalTo(topDividerView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(chooseFamilyButton)
        chooseFamilyButton.snp.makeConstraints {
            $0.top.equalTo(familyLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(chooseFamilyButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(nameField)
        nameField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints {
            $0.top.equalTo(nameField.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(phoneField)
        phoneField.snp.makeConstraints {
            $0.top.equalTo(phoneLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(bottomDividerView)
        bottomDividerView.snp.makeConstraints {
            $0.top.equalTo(phoneField.snp.bottom).offset(Constants.spacing)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }

        contentView.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(bottomDividerView.snp.bottom).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
            $0.width.equalToSuperview().multipliedBy(0.4)
        }
    }
    
    @objc private func didTapCloseButton() {
        self.dismiss()
    }
}
