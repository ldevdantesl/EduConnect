//
//  AddENTSubjectPopUpView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import UIKit
import SnapKit

struct AddENTSubjectPopUpViewModel: PopUpViewModel {
    var onClose: (() -> Void)?
    var didAddNewSubject: ((String, String?) -> Void)?
}

final class AddENTSubjectPopUpView: PopUpView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let xmarkImage = "xmark"
        static let xmarkButtonSize = 20.0
        static let smallSpacing = 5.0
        static let spacing = 10.0
        static let bigSpacing = 20.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: AddENTSubjectPopUpViewModel
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add ENT subject"
        label.font = ECFont.font(.bold, size: 16)
        return label
    }()
    
    private lazy var xmarkButton: ECIconButton = {
        let vm = ECIconButtonVM(systemImage: Constants.xmarkImage) { [weak self] in self?.didTapCloseButton() }
        let button = ECIconButton(viewModel: vm)
        return button
    }()
    
    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.text = "Subject *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score *"
        label.textColor = .label
        label.font = ECFont.font(.medium, size: 14)
        return label
    }()
    
    private let scoreField: ECTextField = {
        let field = ECTextField(placeHolder: "Score: 10")
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
        let button = ECButton(text: "Cancel", backgroundColor: .white, textColor: .blue)
        button.borderColor = .blue
        button.borderWidth = 1
        button.setAction { [weak self] in self?.didTapCloseButton() }
        return button
    }()
    
    private lazy var addButton: ECButton = {
        let button = ECButton(text: "Add")
        return button
    }()
    
    private lazy var subjectMenu: UIMenu = {
        let subjects = ENTSubject.allSubjects
        let actions = subjects.map { subject in
            let subjectTitle = subject.localizedName(lang: SharedConstants.currentLangugage)
            return UIAction(title: subjectTitle) { [weak self] _ in
                var title = AttributedString(subjectTitle)
                title.font = ECFont.font(.semiBold, size: 14)
                title.foregroundColor = .label
                
                self?.chooseSubjectButton.configuration?.attributedTitle = title
            }
        }
        
        return UIMenu(title: "Subject", children: actions)
    }()
    
    private lazy var chooseSubjectButton: UIButton = {
        var title = AttributedString("Choose Subject")
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
        button.menu = subjectMenu
        return button
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: AddENTSubjectPopUpViewModel, closesOnBackgroundTap: Bool = true, animationDuration: TimeInterval = 0.5) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel, closesOnBackgroundTap: closesOnBackgroundTap, animationDuration: animationDuration)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chooseSubjectButton.layer.borderColor = UIColor.black.cgColor
        chooseSubjectButton.layer.cornerRadius = 10
        chooseSubjectButton.layer.borderWidth = 1
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
        
        contentView.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints {
            $0.top.equalTo(topDividerView.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(chooseSubjectButton)
        chooseSubjectButton.snp.makeConstraints {
            $0.top.equalTo(subjectLabel.snp.bottom).offset(Constants.smallSpacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints {
            $0.top.equalTo(chooseSubjectButton.snp.bottom).offset(Constants.spacing)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(scoreField)
        scoreField.snp.makeConstraints {
            $0.top.equalTo(scoreLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(Constants.spacing)
        }
        
        contentView.addSubview(bottomDividerView)
        bottomDividerView.snp.makeConstraints {
            $0.top.equalTo(scoreField.snp.bottom).offset(Constants.spacing)
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
