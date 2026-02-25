//
//  ECIconButton.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 3.01.2026.
//

import UIKit

public struct ECIconButtonVM {
    public var icon: UIImage
    public var color: UIColor
    public var style: UIFont.TextStyle
    public var weight: UIImage.SymbolWeight
    public var didTapAction: (() -> Void)?
    
    public init(
        iconName: String,
        color: UIColor = .systemBlue,
        style: UIFont.TextStyle = .body,
        weight: UIImage.SymbolWeight = .regular,
        didTapAction: (() -> Void)? = nil
    ) {
        self.icon = UIImage(named: iconName) ?? UIImage(systemName: "questionmark.circle")!
        self.color = color
        self.style = style
        self.weight = weight
        self.didTapAction = didTapAction
    }
    
    public init(
        systemImage: String, color: UIColor = .systemBlue,
        style: UIFont.TextStyle = .body,
        weight: UIImage.SymbolWeight = .regular,
        didTapAction: (() -> Void)? = nil
    ) {
        self.icon = UIImage(systemName: systemImage) ?? UIImage(systemName: "questionmark.circle")!
        self.color = color
        self.style = style
        self.weight = weight
        self.didTapAction = didTapAction
    }
}

open class ECIconButton: UIButton {
    
    // MARK: - PROPERTIES
    private var viewModel: ECIconButtonVM?
    private var action: (() -> Void)?
    
    // MARK: - INIT
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(viewModel: ECIconButtonVM) {
        self.init(frame: .zero)
        self.viewModel = viewModel
        setup()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        self.configuration = .plain()
        
        guard let viewModel = viewModel else { return }
        
        var config = UIButton.Configuration.plain()
        config.image = viewModel.icon
        let symbolConfig = UIImage.SymbolConfiguration(textStyle: viewModel.style)
            .applying(UIImage.SymbolConfiguration(weight: viewModel.weight))
        config.preferredSymbolConfigurationForImage = symbolConfig
        config.baseForegroundColor = viewModel.color
        self.isUserInteractionEnabled = true
        self.configuration = config
        self.action = viewModel.didTapAction
        self.addTarget(self, action: #selector(didTapAction), for: .touchUpInside)
    }
    
    // MARK: - PUBLIC FUNC
    public func configure(viewModel: ECIconButtonVM) {
        self.viewModel = viewModel
        setup()
    }
    
    public func setAction(action: (() -> Void)?) {
        self.action = action
    }
    
    // MARK: - OBJC FUNC
    @objc private func didTapAction() {
        action?()
    }
}
