//
//  ECButton.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit

final class ECButton: UIButton {
    
    private var action: (() -> Void)?
    private var cornerRadius: CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) {
                self.alpha = self.isHighlighted ? 0.6 : 1.0
                self.transform = self.isHighlighted
                ? CGAffineTransform(scaleX: 0.97, y: 0.97)
                : .identity
            }
        }
    }
    
    convenience init(text: String, cornerRadius: CGFloat = 15) {
        self.init(frame: .zero)
        let attrTitle = NSAttributedString(
            string: text,
            attributes: [
                .font: ECFont.font(.semiBold, size: 16),
                .foregroundColor: UIColor.white
            ]
        )
        
        setAttributedTitle(attrTitle, for: .normal)
        self.cornerRadius = cornerRadius
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.backgroundColor = .systemBlue
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRadius
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setAction(action: (() -> Void)?) {
        self.action = action
    }
    
    @objc private func didTap() {
        action?()
    }
}
