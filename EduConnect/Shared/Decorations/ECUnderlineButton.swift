//
//  ECUnderlineButton.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.01.2026.
//

import UIKit
import SnapKit

final class ECUnderlineButton: UIView {
    // MARK: - CONSTANTS
    fileprivate enum Constants {
        static let spacing = 5.0
    }
    
    // MARK: - PROPERTIES
    private var action: (() -> Void)?
    
    // MARK: - VIEW PROPERTIES
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let underlineView: UIView = UIView()
    
    var isEnabled: Bool = true {
        didSet {
            isUserInteractionEnabled = isEnabled
            UIView.animate(withDuration: 0.2) {
                self.alpha = self.isEnabled ? 1.0 : 0.5
            }
        }
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(text: String, textSize: CGFloat = 14, textColor: UIColor = UIColor.systemGray) {
        self.init(frame: .zero)
        self.textLabel.text = text
        self.textLabel.font = ECFont.font(.semiBold, size: textSize)
        self.textLabel.textColor = textColor
        self.textLabel.textAlignment = .center
        self.underlineView.backgroundColor = textColor
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.underlineView.layer.cornerRadius = 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.6
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(withDuration: 0.15) {
            self.alpha = 1.0
            self.transform = .identity
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        UIView.animate(withDuration: 0.15) {
            self.alpha = 1.0
            self.transform = .identity
        }
    }
    
    // MARK: - PUBLIC FUNC
    public func setAction(action: (() -> Void)?) {
        self.action = action
    }
    
    public func configure(text: String, textSize: CGFloat = 14, textColor: UIColor = UIColor.systemGray) {
        self.textLabel.text = text
        self.textLabel.font = ECFont.font(.semiBold, size: textSize)
        self.textLabel.textColor = textColor
        self.textLabel.textAlignment = .center
        self.underlineView.backgroundColor = textColor
    }
    
    public func setTitle(_ text: String) {
        self.textLabel.text = text
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        self.addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(Constants.spacing)
            $0.centerX.equalTo(textLabel)
            $0.width.equalTo(textLabel)
            $0.height.equalTo(2)
            $0.bottom.equalToSuperview()
        }
        
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap))
        self.addGestureRecognizer(gesture)
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTap() {
        animateTap(onCompletion: action)
    }
}
