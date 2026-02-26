//
//  LoadingCell.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 29.01.2026.
//

import UIKit
import SnapKit

struct LoadingCellViewModel { }

final class LoadingCell: UICollectionViewCell {
    
    // MARK: - VIEW PROPERTIES
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = ImageConstants.appLogo.image
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        label.font = ECFont.font(.medium, size: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private var shimmerLayers: [CAGradientLayer] = []
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShimmerFrames()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopShimmer()
    }
    
    // MARK: - PUBLIC FUNC
    func configure(withVM vm: LoadingCellViewModel) {
        startShimmer()
    }
    
    // MARK: - PRIVATE FUNC
    private func setupUI() {
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(40)
            $0.size.equalTo(60)
        }
        
        contentView.addSubview(loadingLabel)
        loadingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func startShimmer() {
        stopShimmer()
    
        DispatchQueue.main.async { [weak self] in
            self?.addShimmerToViews()
        }
    }

    private func addShimmerToViews() {
        [logoImageView, loadingLabel].forEach { view in
            let shimmer = CAGradientLayer()
            shimmer.colors = [
                UIColor.white.withAlphaComponent(0.0).cgColor,
                UIColor.white.withAlphaComponent(0.8).cgColor,
                UIColor.white.withAlphaComponent(0.0).cgColor
            ]
            shimmer.locations = [0, 0.5, 1]
            shimmer.startPoint = CGPoint(x: 0, y: 0.5)
            shimmer.endPoint = CGPoint(x: 1, y: 0.5)
            shimmer.frame = CGRect(
                x: -view.bounds.width,
                y: 0,
                width: view.bounds.width * 3,
                height: view.bounds.height
            )
            
            view.layer.addSublayer(shimmer)
            shimmerLayers.append(shimmer)
            
            let animation = CABasicAnimation(keyPath: "position.x")
            animation.fromValue = -view.bounds.width
            animation.toValue = view.bounds.width * 2
            animation.duration = 1.0
            animation.repeatCount = .infinity
            shimmer.add(animation, forKey: "shimmer")
        }
    }

    private func stopShimmer() {
        shimmerLayers.forEach { $0.removeFromSuperlayer() }
        shimmerLayers.removeAll()
    }

    private func updateShimmerFrames() {
        guard shimmerLayers.count == 2 else { return }
        
        let views = [logoImageView, loadingLabel]
        for (index, view) in views.enumerated() {
            shimmerLayers[index].frame = CGRect(
                x: -view.bounds.width,
                y: 0,
                width: view.bounds.width * 3,
                height: view.bounds.height
            )
        }
    }
}
