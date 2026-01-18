//
//  ECTextField.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit

open class ECTextField: UITextField, UITextFieldDelegate {
    
    private var cornerRadius: CGFloat = 15
    private var returnAction: (() -> Void)?
    private var showsBorder: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    func configure(placeHolder: String, showsBorder: Bool = true, cornerRadius: CGFloat = 15, returnKeyType: UIReturnKeyType = .done, returnAction: (() -> Void)? = nil) {
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
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if showsBorder {
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.systemGray2.cgColor
            layoutIfNeeded()
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 10, dy: 10)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        returnAction?()
        return true
    }
}
