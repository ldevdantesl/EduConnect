//
//  ECDashedBorderButton.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

final class ECDashedBorderButton: UIControl {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let dashPattern: [NSNumber] = [8, 6]
        static let borderWidth: CGFloat = 2.0
    }
    
    // MARK: - OVERRIDEN PROPERTIES
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15) { [weak self] in
                guard let self = self else { return }
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.97, y: 0.97) : .identity
                self.alpha = self.isHighlighted ? 0.9 : 1.0
            }
        }
    }
    
    // MARK: - PROPERTIES
    private let dashedBorderLayer = CAShapeLayer()
    
    // MARK: - PUBLIC PROPERTIES
    public var titleText: String? {
        didSet { titleLabel.text = titleText }
    }
    
    public var subtitleText: String? {
        didSet { countLabel.text = subtitleText }
    }
    
    public var cornerRadius: CGFloat = 30.0 {
        didSet {
            gradientView.layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    // MARK: - Title styling
    public var titleFont: UIFont = .systemFont(ofSize: 16, weight: .semibold) {
        didSet { titleLabel.font = titleFont }
    }

    public var titleColor: UIColor = .white {
        didSet { titleLabel.textColor = titleColor }
    }

    // MARK: - Subtitle styling
    public var subtitleFont: UIFont = .systemFont(ofSize: 13, weight: .medium) {
        didSet { countLabel.font = subtitleFont }
    }

    public var subtitleColor: UIColor = UIColor.white.withAlphaComponent(0.8) {
        didSet { countLabel.textColor = subtitleColor }
    }
    
    public var image: UIImage? {
        didSet { iconImageView.image = image }
    }
    
    public var imageSize: CGFloat = 80.0
    
    public var gradientColors: [UIColor] = [
        UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: 1),
        UIColor(red: 90/255, green: 170/255, blue: 255/255, alpha: 1)
    ] {
        didSet {
            gradientLayer.colors = gradientColors.map { $0.cgColor }
        }
    }
    
    // MARK: - VIEW PROPERTIES
    private let gradientView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        return layer
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.9)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    // MARK: - SETUP
    private func setupUI() {
        dashedBorderLayer.fillColor = UIColor.clear.cgColor
        dashedBorderLayer.strokeColor = UIColor(red: 90/255, green: 170/255, blue: 255/255, alpha: 1).cgColor
        dashedBorderLayer.lineWidth = Constants.borderWidth
        dashedBorderLayer.lineDashPattern = Constants.dashPattern
        layer.addSublayer(dashedBorderLayer)
        
        addSubview(gradientView)
        gradientView.layer.addSublayer(gradientLayer)
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, countLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        
        gradientView.addSubview(labelsStack)
        labelsStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        gradientView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(imageSize)
        }
        
        gradientLayer.colors = gradientColors.map { $0.cgColor }
    }
    
    private func updateLayers() {
        let newPath = CGMutablePath()
        newPath.addRoundedRect(
            in: bounds,
            cornerWidth: cornerRadius,
            cornerHeight: cornerRadius
        )
        
        dashedBorderLayer.path = newPath
        dashedBorderLayer.frame = bounds
        
        gradientView.layer.cornerRadius = cornerRadius
        gradientLayer.frame = gradientView.bounds
    }
}
