//
//  ECDashedBorderButton.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit
import SnapKit

final class ECDashedBorderButton: ECDashedBorderView {
    
    // MARK: - CONSTANTS
    private enum Constants {
        static let defaultImageSize: CGFloat = 80.0
    }
    
    // MARK: - PROPERTIES
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        return layer
    }()
    
    // MARK: - PUBLIC PROPERTIES
    var titleText: String? {
        didSet { titleLabel.text = titleText }
    }
    
    var subtitleText: String? {
        didSet { subtitleLabel.text = subtitleText }
    }
    
    var titleFont: UIFont = .systemFont(ofSize: 16, weight: .semibold) {
        didSet { titleLabel.font = titleFont }
    }

    var titleColor: UIColor = .white {
        didSet { titleLabel.textColor = titleColor }
    }

    var subtitleFont: UIFont = .systemFont(ofSize: 13, weight: .medium) {
        didSet { subtitleLabel.font = subtitleFont }
    }

    var subtitleColor: UIColor = UIColor.white.withAlphaComponent(0.8) {
        didSet { subtitleLabel.textColor = subtitleColor }
    }
    
    var image: UIImage? {
        didSet { iconImageView.image = image }
    }
    
    var gradientColors: [UIColor] = [
        UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: 1),
        UIColor(red: 90/255, green: 170/255, blue: 255/255, alpha: 1)
    ] {
        didSet {
            gradientLayer.colors = gradientColors.map { $0.cgColor }
        }
    }
    
    // MARK: - VIEW PROPERTIES
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white.withAlphaComponent(0.9)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContent()
    }
    
    // MARK: - LIFECYCLE
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
    
    // MARK: - PRIVATE FUNC
    private func setupContent() {
        cornerRadius = 30.0
        
        contentView.layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.colors = gradientColors.map { $0.cgColor }
        
        let labelsStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(iconImageView.snp.height).multipliedBy(1.3)
        }
        
        contentView.addSubview(labelsStack)
        labelsStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(iconImageView.snp.leading).offset(-10)
        }
    }
}
