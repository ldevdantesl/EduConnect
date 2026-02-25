//
//  ECDashedBorderView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

class ECDashedBorderView: UIView {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let dashPattern: [NSNumber] = [8, 6]
        static let borderWidth: CGFloat = 2.0
        static let defaultCornerRadius: CGFloat = 20.0
        static let defaultContentInset: CGFloat = 6.0
        static let defaultBorderColor = UIColor(red: 90/255, green: 170/255, blue: 255/255, alpha: 1)
    }
    
    // MARK: - PROPERTIES
    private let dashedBorderLayer = CAShapeLayer()
    
    // MARK: - PUBLIC PROPERTIES
    var cornerRadius: CGFloat = Constants.defaultCornerRadius {
        didSet {
            contentView.layer.cornerRadius = cornerRadius - contentInset
            setNeedsLayout()
        }
    }
    
    var contentInset: CGFloat = Constants.defaultContentInset {
        didSet {
            contentView.layer.cornerRadius = cornerRadius - contentInset
            contentView.snp.updateConstraints {
                $0.edges.equalToSuperview().inset(contentInset)
            }
        }
    }
    
    var borderColor: UIColor = Constants.defaultBorderColor {
        didSet { dashedBorderLayer.strokeColor = borderColor.cgColor }
    }
    
    var dashPattern: [NSNumber] = Constants.dashPattern {
        didSet { dashedBorderLayer.lineDashPattern = dashPattern }
    }
    
    var borderWidth: CGFloat = Constants.borderWidth {
        didSet { dashedBorderLayer.lineWidth = borderWidth }
    }
    
    var showShadow: Bool = false {
        didSet { updateShadow() }
    }
    
    var shadowColor: UIColor = .black {
        didSet { layer.shadowColor = shadowColor.cgColor }
    }
    
    var shadowOpacity: Float = 0.15 {
        didSet { layer.shadowOpacity = showShadow ? shadowOpacity : 0 }
    }
    
    var shadowRadius: CGFloat = 12 {
        didSet { layer.shadowRadius = shadowRadius }
    }
    
    var shadowOffset: CGSize = CGSize(width: 0, height: 4) {
        didSet { layer.shadowOffset = shadowOffset }
    }
    
    private(set) var onTap: (() -> Void)?
    
    // MARK: - VIEW PROPERTIES
    let contentView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - LIFECYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorderPath()
        updateShadowPath()
    }
    
    // MARK: - PRIVATE FUNC
    private func setup() {
        backgroundColor = .clear
        
        dashedBorderLayer.fillColor = UIColor.clear.cgColor
        dashedBorderLayer.strokeColor = borderColor.cgColor
        dashedBorderLayer.lineWidth = borderWidth
        dashedBorderLayer.lineDashPattern = dashPattern
        layer.addSublayer(dashedBorderLayer)
        
        addSubview(contentView)
        contentView.layer.cornerRadius = cornerRadius - contentInset
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(contentInset)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tap)
    }
    
    private func updateBorderPath() {
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        dashedBorderLayer.path = path.cgPath
        dashedBorderLayer.frame = bounds
    }
    
    private func updateShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = showShadow ? shadowOpacity : 0
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false
        updateShadowPath()
    }
    
    private func updateShadowPath() {
        guard showShadow else { return }
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
    // MARK: - PUBLIC FUNC
    func setAction(action: (() -> Void)?) {
        self.onTap = action
    }
    
    // MARK: - OBJC FUNC
    @objc private func handleTap() {
        self.contentView.animateTap(onCompletion: onTap)
    }
}
