//
//  HomeScreenExpandableENTCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 18.01.2026.
//

import UIKit
import SnapKit

final class AccountScreenExpandableENTCellViewModel: ExpandableCellViewModel {
    let cellIdentifier: String = AccountScreenExpandableENTCell.identifier
    let profile: Profile
    var isExpanded: Bool
    let didTapExpand: (() -> Void)?
    let didTapAddNewSubject: (() -> Void)?
    let didSetNewENTYear: ((Int) -> Void)?
    let didTapDeleteSubject: ((ProfileETH.Subject) -> Void)?
    
    var ethSubjects: [ProfileETH.Subject] {
        profile.eth.subjects
    }
    
    init(
        profile: Profile,
        isExpanded: Bool,
        didTapExpand: (() -> Void)? = nil,
        didTapAddNewSubject: (() -> Void)? = nil,
        didSetNewENTYear: ((Int) -> Void)? = nil,
        didTapDeleteSubject: ((ProfileETH.Subject) -> Void)? = nil
    ) {
        self.profile = profile
        self.isExpanded = isExpanded
        self.didTapExpand = didTapExpand
        self.didTapAddNewSubject = didTapAddNewSubject
        self.didSetNewENTYear = didSetNewENTYear
        self.didTapDeleteSubject = didTapDeleteSubject
    }
}

final class AccountScreenExpandableENTCell: UICollectionViewCell, ConfigurableCellProtocol {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 10.0
        
        static let plusImageName = "plus"
        static let expandImageSize = 20.0
        static let chevronDownImage = "chevron.down"
        static let chevronUpImage = "chevron.up"
        static let chipsHeight = 50.0
    }
    
    // MARK: - PROPERTIES
    private var viewModel: AccountScreenExpandableENTCellViewModel?
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.ENT.title
        label.font = ECFont.font(.semiBold, size: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    private let yearOfENTLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.ENT.yearOfSubmission
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let yearOfENTField: ECTextField = {
        let field = ECTextField(placeHolder: "2025", showsBorder: false)
        field.maximumCharacters = 4
        field.isEnabled = false
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var setYearButton: ECButton = {
        let button = ECButton(text: ConstantLocalizedStrings.Common.set)
        button.setAction { [weak self] in
            guard let self = self else { return }
            self.didPressSetYearButton()
        }
        return button
    }()
    
    private let subjectsENTLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantLocalizedStrings.Account.Expandable.ENT.entSubjects
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private let subjectsScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        return scroll
    }()
    
    private let subjectsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private lazy var addSubjectButton: UIView = makeAddSubjectButton()

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
        subjectsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: any CellViewModelProtocol) {
        guard let vm = vm as? AccountScreenExpandableENTCellViewModel else { return }
        self.viewModel = vm
        vm.isExpanded ? expandCell() : collapseCell()
        
        yearOfENTField.text = vm.profile.eth.year?.description
        populateSubjects()
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
        
        headerContainer.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
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
        
        expandableContainer.addSubview(yearOfENTLabel)
        yearOfENTLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        expandableContainer.addSubview(yearOfENTField)
        yearOfENTField.snp.makeConstraints {
            $0.top.equalTo(yearOfENTLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().multipliedBy(0.4)
        }
        
        expandableContainer.addSubview(setYearButton)
        setYearButton.snp.makeConstraints {
            $0.top.equalTo(yearOfENTField.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.trailing.equalToSuperview().offset(-Constants.spacing)
        }
        
        expandableContainer.addSubview(subjectsENTLabel)
        subjectsENTLabel.snp.makeConstraints {
            $0.top.equalTo(setYearButton.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        expandableContainer.addSubview(subjectsScrollView)
        subjectsScrollView.snp.makeConstraints {
            $0.top.equalTo(subjectsENTLabel.snp.bottom).offset(Constants.spacing).priority(.high)
            $0.horizontalEdges.equalToSuperview()
        }

        subjectsScrollView.addSubview(subjectsStackView)
        subjectsStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
            $0.height.equalToSuperview()
        }
        
        expandableContainer.addSubview(addSubjectButton)
        addSubjectButton.snp.makeConstraints {
            $0.top.equalTo(subjectsScrollView.snp.bottom).offset(Constants.spacing)
            $0.leading.equalToSuperview().offset(Constants.spacing)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
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
    
    private func didPressSetYearButton() {
        if !isEditing {
            yearOfENTField.reconfigure(showsBorder: true)
            yearOfENTField.isEnabled = true
            setYearButton.reconfigure(text: ConstantLocalizedStrings.Common.save)
        } else {
            yearOfENTField.reconfigure(showsBorder: false)
            yearOfENTField.isEnabled = false
            setYearButton.reconfigure(text: ConstantLocalizedStrings.Common.set)
            if let year = Int(yearOfENTField.text ?? "0") {
                self.viewModel?.didSetNewENTYear?(year)
            }
        }
        isEditing.toggle()
    }
    
    private func makeAddSubjectButton() -> UIView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: Constants.plusImageName)
        imageView.tintColor = .systemBlue
        
        let addSubjectTextLabel = UILabel()
        addSubjectTextLabel.text = ConstantLocalizedStrings.Account.Expandable.ENT.addEntSubjects
        addSubjectTextLabel.textColor = .systemBlue
        addSubjectTextLabel.font = ECFont.font(.regular, size: 14)
        
        
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAddSubject)))
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(Constants.expandImageSize)
        }
        
        view.addSubview(addSubjectTextLabel)
        addSubjectTextLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(Constants.spacing)
            $0.trailing.equalToSuperview().offset(Constants.spacing)
            $0.centerY.equalTo(imageView)
            $0.bottom.equalToSuperview().offset(-Constants.spacing)
        }
        
        return view
    }
    
    private func populateSubjects() {
        subjectsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        viewModel?.ethSubjects.forEach { subject in
            let vm = DeletableChipViewModel(title: "\(subject.subject.name.ru) - \(subject.score ?? 0)")
            let chip = DeletableChipCell(viewModel: vm)
            chip.setDeleteAction { [weak self] in
                self?.viewModel?.didTapDeleteSubject?(subject)
            }
            subjectsStackView.addArrangedSubview(chip)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapExpand() {
        viewModel?.didTapExpand?()
    }
    
    @objc private func didTapAddSubject() {
        self.viewModel?.didTapAddNewSubject?()
    }
}
