//
//  ECTextField.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit

final class ECTextField: UITextField, UITextFieldDelegate {
    
    private var cornerRadius: CGFloat = 0
    private var returnAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(placeHolder: String, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        self.placeholder = placeHolder
        self.cornerRadius = cornerRadius
        self.returnKeyType = .done
        self.delegate = self
        layoutIfNeeded()
    }
    
    convenience init(placeHolder: String, cornerRadius: CGFloat, returnKeyType: UIReturnKeyType, returnAction: (() -> Void)? = nil) {
        self.init(frame: .zero)
        self.placeholder = placeHolder
        self.cornerRadius = cornerRadius
        self.returnKeyType = returnKeyType
        self.returnAction = returnAction
        self.delegate = self
        layoutIfNeeded()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray2.cgColor
        layoutIfNeeded()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        returnAction?()
        return true
    }
}
