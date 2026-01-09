//
//  ECSecureTextField.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit
import SnapKit

final class ECSecureTextField: ECTextField {

    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let eyeSlashImageName = "eye.slash"
        static let eyeImageName = "eye"
        
        static let rightViewBounds: CGFloat = 32
        static let toggleButtonSize: CGFloat = 25
    }
    
    private let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: Constants.eyeSlashImageName), for: .normal)
        button.tintColor = .systemBlue
        button.frame = CGRect(x: 0, y: 0, width: Constants.toggleButtonSize, height: Constants.toggleButtonSize)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSecure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupSecure() {
        isSecureTextEntry = true
        configureRightView()
    }

    private func configureRightView() {
        toggleButton.addTarget(self, action: #selector(toggleSecure), for: .touchUpInside)
        self.rightView = toggleButton
        self.rightViewMode = .always
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: bounds.width - 40,
            y: (bounds.height - Constants.rightViewBounds) / 2,
            width: Constants.rightViewBounds,
            height: Constants.rightViewBounds
        )
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 44))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 44))
    }

    @objc private func toggleSecure() {
        isSecureTextEntry.toggle()
        toggleButton.setImage(
            UIImage(systemName: isSecureTextEntry ? Constants.eyeSlashImageName : Constants.eyeImageName),
            for: .normal
        )
    }
}
