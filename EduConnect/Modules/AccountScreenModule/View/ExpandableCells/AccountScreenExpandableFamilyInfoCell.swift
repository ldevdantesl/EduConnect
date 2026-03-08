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
    let didTapAddFamily: (() -> Void)?
    let didTapDeleteFamily: ((ProfileFamilyContact) -> Void)?
    
    init(profile: Profile, isExpanded: Bool, didTapExpand: (() -> Void)? = nil, didTapAddFamily: (() -> Void)? = nil, didTapDeleteFamily: ((ProfileFamilyContact) -> Void)? = nil) {
        self.profile = profile
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
        self.didTapAddFamily = didTapAddFamily
        self.didTapDeleteFamily = didTapDeleteFamily
    }
}

final class AccountScreenExpandableFamilyInfoCell: UICollectionViewCell, ExpandableCellProtocol {
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
    
    private let familyStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.spacing = 10
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var addButton: UIView = makeAddFamilyButton()
    
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
    func configure(withVM vm: any ExpandableCellViewModel) {
        guard let vm = vm as? AccountScreenExpandableFamilyInfoCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
        populateFamilies()
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

        expandableContainer.addSubview(familyStack)
        familyStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }

        expandableContainer.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(familyStack.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview()
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
    
    private func makeAddFamilyButton() -> UIView {
        let imageView = UIImageView()
        imageView.image = ImageConstants.SystemImages.plus.image
        imageView.tintColor = .systemBlue
        
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.FamilyInfo.addContact
        label.textColor = .systemBlue
        label.font = ECFont.font(.regular, size: 14)
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAddFamilyMember)))
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(Constants.expandImageSize)
        }
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(imageView)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
        
        return view
    }
    
    private func populateFamilies() {
        familyStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        viewModel?.profile.familyContacts.forEach { family in
            let vm = DeletableFamilyMemberViewModel(name: family.fullName, phoneNumber: family.phoneNumber, typeName: family.familyMemberName)
            let view = DeletableFamilyMemberView(viewModel: vm)
            view.setDeleteAction { [weak self] in
                self?.viewModel?.didTapDeleteFamily?(family)
            }
            familyStack.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapExpand() {
        viewModel?.didTapExpand?()
    }
    
    @objc private func didTapAddFamilyMember() {
        viewModel?.didTapAddFamily?()
    }
}
