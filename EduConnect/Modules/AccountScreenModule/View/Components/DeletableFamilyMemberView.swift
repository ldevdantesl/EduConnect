//
//  DeletableFamilyMemberView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import UIKit
import SnapKit

struct DeletableFamilyMemberViewModel {
    let name: String?
    let phoneNumber: String
    let typeName: String
    let onDelete: (() -> Void)?
    
    init(name: String?, phoneNumber: String, typeName: String, onDelete: (() -> Void)? = nil) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.typeName = typeName
        self.onDelete = onDelete
    }
}

final class DeletableFamilyMemberView: UIView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 10.0
        static let spacing = 5.0
        static let buttonSize = 30.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: DeletableFamilyMemberViewModel
    private var onDelete: (() -> Void)?
    
    // MARK: - VIEW PROPERTIES
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 16)
        label.textColor = .label
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.bold, size: 14)
        label.textColor = .label
        return label
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.semiBold, size: 12)
        label.textColor = .label
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageConstants.SystemImages.trash.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
        return button
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [typeLabel, nameLabel, phoneLabel])
        stack.axis = .vertical
        stack.spacing = Constants.hSpacing
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [deleteButton, vStack])
        stack.axis = .horizontal
        stack.spacing = Constants.hSpacing
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: DeletableFamilyMemberViewModel) {
        self.viewModel = viewModel
        self.onDelete = viewModel.onDelete
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    func setDeleteAction(action: (() -> Void)?) {
        self.onDelete = action
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        typeLabel.text = viewModel.typeName
        nameLabel.text = viewModel.name
        phoneLabel.text = viewModel.phoneNumber
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        
        addSubview(hStack)
        hStack.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Constants.hSpacing)
            $0.verticalEdges.equalToSuperview().inset(Constants.hSpacing)
        }
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapDelete() {
        deleteButton.animateTap(onCompletion: onDelete)
    }
}
