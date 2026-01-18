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
    
    var config = UIButton.Configuration.plain()
    
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
    
    convenience init(
        text: String, textSize: CGFloat = 16,
        backgroundColor: UIColor = .systemBlue,
        textColor: UIColor = .white, cornerRadius: CGFloat = 15
    ) {
        self.init(frame: .zero)
        configure(
            text: text, textSize: textSize,
            backgroundColor: backgroundColor,
            textColor: textColor, cornerRadius: cornerRadius
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRadius
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(
        text: String,
        textSize: CGFloat = 16,
        backgroundColor: UIColor = .systemBlue,
        textColor: UIColor = .white,
        cornerRadius: CGFloat = 15
    ) {
        var title = AttributedString(text)
        title.font = ECFont.font(.semiBold, size: textSize)
        title.foregroundColor = textColor

        config.attributedTitle = title
        config.titleLineBreakMode = .byTruncatingTail
        self.backgroundColor = backgroundColor
        self.configuration = config
        self.cornerRadius = cornerRadius
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    public func reconfigure(
        text: String? = nil,
        textSize: CGFloat? = nil,
        backgroundColor: UIColor? = nil,
        textColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil
    ) {
        var config = self.configuration ?? .plain()

        var title = config.attributedTitle ?? AttributedString("")

        if let text {
            title.characters = AttributedString(text).characters
        }
        if let textSize {
            title.font = ECFont.font(.semiBold, size: textSize)
        }
        if let textColor {
            title.foregroundColor = textColor
        }

        config.attributedTitle = title

        if let backgroundColor {
            config.background.backgroundColor = backgroundColor
        }
        if let cornerRadius {
            config.background.cornerRadius = cornerRadius
        }

        self.configuration = config
        layoutIfNeeded()
        
    }
    
    public func setAction(action: (() -> Void)?) {
        self.action = action
    }
    
    public func setContentInsets(insets: NSDirectionalEdgeInsets) {
        config.contentInsets = insets
        self.configuration = config
        layoutIfNeeded()
    }
    
    @objc private func didTap() {
        action?()
    }
}
