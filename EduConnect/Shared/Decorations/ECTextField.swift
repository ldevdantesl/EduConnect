//
//  ECTextField.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit

open class ECTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - PROPERTIES
    var cornerRadius: CGFloat = 15
    var returnAction: (() -> Void)?
    var showsBorder: Bool = true
    var maximumCharacters = 0
    
    // MARK: - OVERRIDDEN
    open override var keyboardType: UIKeyboardType {
        didSet {
            updateInputAccessoryIfNeeded()
        }
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = ECFont.font(.medium, size: 14)
    }
    
    convenience init(placeHolder: String, showsBorder: Bool = true, cornerRadius: CGFloat = 15) {
        self.init(frame: .zero)
        configure(placeHolder: placeHolder, showsBorder: showsBorder, cornerRadius: cornerRadius)
    }
    
    convenience init(placeHolder: String, showsBorder: Bool = true, cornerRadius: CGFloat = 15, returnKeyType: UIReturnKeyType, returnAction: (() -> Void)? = nil) {
        self.init(frame: .zero)
        configure(placeHolder: placeHolder, showsBorder: showsBorder, cornerRadius: cornerRadius, returnKeyType: returnKeyType, returnAction: returnAction)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if showsBorder {
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray2.cgColor
        } else {
            layer.cornerRadius = 0
            layer.borderWidth = 0
            layer.borderColor = nil
        }
        layoutIfNeeded()
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(
        placeHolder: String,
        showsBorder: Bool = true,
        cornerRadius: CGFloat = 15,
        returnKeyType: UIReturnKeyType = .done,
        returnAction: (() -> Void)? = nil
    ) {
        let attrPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [
                .foregroundColor: UIColor.systemGray,
                .font: ECFont.font(.medium, size: 14)
            ]
        )
        self.attributedPlaceholder = attrPlaceholder
        self.cornerRadius = cornerRadius
        self.returnKeyType = returnKeyType
        self.returnAction = returnAction
        self.showsBorder = showsBorder
        self.delegate = self
        updateInputAccessoryIfNeeded()
    }
    
    public func reconfigure(
        placeHolder: String? = nil,
        showsBorder: Bool? = nil,
        cornerRadius: CGFloat? = nil,
        returnKeyType: UIReturnKeyType? = nil,
        returnAction: (() -> Void)? = nil
    ) {
        if let placeHolder {
            self.attributedPlaceholder = NSAttributedString(
                string: placeHolder,
                attributes: [
                    .foregroundColor: UIColor.systemGray,
                    .font: ECFont.font(.medium, size: 14)
                ]
            )
        }
        
        if let showsBorder { self.showsBorder = showsBorder }
        if let cornerRadius { self.cornerRadius = cornerRadius }
        if let returnKeyType { self.returnKeyType = returnKeyType }
        if let returnAction { self.returnAction = returnAction }
        
        self.delegate = self
        setNeedsLayout()
    }
    
    // MARK: - PRIVATE FUNC
    private func updateInputAccessoryIfNeeded() {
        switch keyboardType {
        case .numberPad, .phonePad:
            let toolbar = UIToolbar()
            toolbar.sizeToFit()

            let flex = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )

            let done = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(doneTapped)
            )

            toolbar.items = [flex, done]
            inputAccessoryView = toolbar

        default:
            inputAccessoryView = nil
        }
    }
    
    // MARK: - OVERRIDDEN FUNC
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 10)
    }
    
    // MARK: - DELEGATE
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        returnAction?()
        return true
    }
    
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard maximumCharacters > 0 else { return true }

        let currentText = textField.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: textRange, with: string)
        return updatedText.count <= maximumCharacters
    }
    
    // MARK: - OBJC FUNC
    @objc private func doneTapped() {
        resignFirstResponder()
        returnAction?()
    }
}
