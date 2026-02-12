//
//  ECSearchField.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

final class ECSearchField: UITextField, UITextFieldDelegate {
    
    private let rightViewWidth: CGFloat = 44
    private(set) var tapAction: ((String) -> Void)?

    // MARK: - LIFECYCLE
    init(placeholder: String) {
        super.init(frame: .zero)
        configure(placeholder: placeholder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PUBLIC FUNC
    public func setAction(action: @escaping (String) -> Void) {
        self.tapAction = action
    }
    
    // MARK: - PRIVATE FUNC
    private func configure(placeholder: String) {
        borderStyle = .none
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor

        font = ECFont.font(.medium, size: 14)
        textColor = .label

        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.systemGray,
                .font: ECFont.font(.medium, size: 14)
            ]
        )

        returnKeyType = .search
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        self.delegate = self

        setupSearchIcon()
    }

    private func setupSearchIcon() {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit

        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 36))
        imageView.frame = CGRect(x: 6, y: 8, width: 20, height: 20)
        container.addSubview(imageView)

        rightView = container
        rightViewMode = .always
    }
    
    // MARK: - DELEGATE FUNC
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        guard let text = textField.text else { return true }
        tapAction?(text)
        return true
    }

    // MARK: - PADDING
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 + rightViewWidth))
    }
}
