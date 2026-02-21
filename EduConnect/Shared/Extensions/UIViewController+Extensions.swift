//
//  UIViewController+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 4.01.2026.
//

import UIKit
import SnapKit

extension UIViewController {
    var headerHeight: CGFloat {
        view.safeAreaInsets.top + 100
    }
    
    func showToastedError(message: String) {
        showToast(message: message, backgroundColor: UIColor.black.withAlphaComponent(0.85))
    }

    func showToastedError(userError: UserFacingError) {
        showToast(
            title: userError.title,
            message: userError.message,
            backgroundColor: UIColor.systemRed.withAlphaComponent(0.9)
        )
    }

    func showToastedMessage(message: String) {
        showToast(message: message, backgroundColor: UIColor.systemGreen.withAlphaComponent(0.9))
    }
    
    private func showToast(title: String? = nil, message: String, backgroundColor: UIColor) {
        let toast = UIStackView()
        toast.axis = .vertical
        toast.spacing = 4
        toast.alignment = .center
        toast.backgroundColor = backgroundColor
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.alpha = 0
        toast.isLayoutMarginsRelativeArrangement = true
        toast.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        if let title {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = .white
            titleLabel.font = ECFont.font(.semiBold, size: 15)
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            toast.addArrangedSubview(titleLabel)
        }

        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white.withAlphaComponent(0.9)
        messageLabel.font = ECFont.font(.medium, size: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        toast.addArrangedSubview(messageLabel)

        view.addSubview(toast)
        toast.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(44)
        }

        UIView.animate(withDuration: 0.3) {
            toast.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 2.5, options: []) {
                toast.alpha = 0
            } completion: { _ in
                toast.removeFromSuperview()
            }
        }
    }

}

extension UIViewController {
    private var hoverLoadingTag: Int { 999999 }
    
    func showHoverLoading() {
        guard view.viewWithTag(hoverLoadingTag) == nil else { return }
        
        let overlay = UIView()
        overlay.tag = hoverLoadingTag
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlay.alpha = 0
        
        let logoImageView = UIImageView()
        logoImageView.image = ImageConstants.appLogo.image
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.shadowColor = UIColor.black.cgColor
        logoImageView.layer.shadowOpacity = 0.2
        logoImageView.layer.shadowOffset = CGSize(width: 0, height: 3)
        logoImageView.layer.shadowRadius = 8
        logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        let loadingLabel = UILabel()
        loadingLabel.text = "\(ConstantLocalizedStrings.Common.loading)..."
        loadingLabel.font = ECFont.font(.bold, size: 16)
        loadingLabel.textColor = .systemBlue
        loadingLabel.alpha = 0
        
        overlay.addSubview(logoImageView)
        overlay.addSubview(loadingLabel)
        view.addSubview(overlay)
        
        overlay.snp.makeConstraints { $0.edges.equalToSuperview() }
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(55)
        }
        loadingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(12)
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            overlay.alpha = 1
            logoImageView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3) {
            loadingLabel.alpha = 1
        }
        
        startFloatingAnimation(on: logoImageView)
    }
    
    func hideHoverLoading() {
        guard let overlay = view.viewWithTag(hoverLoadingTag) else { return }
        
        overlay.subviews.forEach { $0.layer.removeAllAnimations() }
        
        UIView.animate(withDuration: 0.25, delay: 0,options: .curveEaseIn) {
            overlay.alpha = 0
            overlay.subviews.forEach { $0.transform = CGAffineTransform(scaleX: 0.01, y: 0.01) }
        } completion: { _ in
            overlay.removeFromSuperview()
        }
    }
    
    private func startFloatingAnimation(on view: UIView) {
        let float = CAKeyframeAnimation(keyPath: "transform.translation.y")
        float.values = [0, -8, 0, -8, 0]
        float.keyTimes = [0, 0.25, 0.5, 0.75, 1.0]
        float.timingFunctions = (0..<4).map { _ in
            CAMediaTimingFunction(controlPoints: 0.45, 0, 0.55, 1)
        }
        float.duration = 1.6
        float.repeatCount = .infinity
        
        let pulse = CAKeyframeAnimation(keyPath: "transform.scale")
        pulse.values = [1.0, 1.06, 1.0, 1.06, 1.0]
        pulse.keyTimes = [0, 0.25, 0.5, 0.75, 1.0]
        pulse.timingFunctions = (0..<4).map { _ in
            CAMediaTimingFunction(controlPoints: 0.45, 0, 0.55, 1)
        }
        pulse.duration = 1.6
        pulse.repeatCount = .infinity
        
        let group = CAAnimationGroup()
        group.animations = [float, pulse]
        group.duration = 1.6
        group.repeatCount = .infinity
        
        view.layer.add(group, forKey: "floatingAnimation")
    }
}
