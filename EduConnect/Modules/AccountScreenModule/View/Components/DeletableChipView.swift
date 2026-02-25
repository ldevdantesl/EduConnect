//
//  DeletableChipView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.02.2026.
//

import UIKit
import SnapKit

struct DeletableChipViewModel {
    let title: String
    let onDelete: (() -> Void)?
    
    init(title: String, onDelete: (() -> Void)? = nil) {
        self.title = title
        self.onDelete = onDelete
    }
}

final class DeletableChipView: UIView {
    
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let hSpacing = 10.0
        static let spacing = 5.0
        static let buttonSize = 30.0
    }
    
    // MARK: - PROPERTIES
    private let viewModel: DeletableChipViewModel
    private var onDelete: (() -> Void)?
    
    // MARK: - VIEW PROPERTIES
    private let label: UILabel = {
        let label = UILabel()
        label.font = ECFont.font(.medium, size: 13)
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
    
    private lazy var hStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [label, deleteButton])
        stack.axis = .horizontal
        stack.spacing = Constants.hSpacing
        stack.alignment = .center
        return stack
    }()
    
    // MARK: - LIFECYCLE
    init(viewModel: DeletableChipViewModel) {
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
        label.text = viewModel.title
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
