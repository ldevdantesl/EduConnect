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
    
    func showError(message: String) {
        let toast = ECPaddedLabel()
        toast.text = message
        toast.numberOfLines = 0
        toast.textColor = .white
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toast.textAlignment = .center
        toast.font = ECFont.font(.medium, size: 14)
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.alpha = 0
        
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
        
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        
        let logoImageView = UIImageView()
        logoImageView.image = ImageConstants.appLogo.image
        logoImageView.contentMode = .scaleAspectFill
        
        let loadingLabel = UILabel()
        loadingLabel.text = "Загрузка..."
        loadingLabel.font = ECFont.font(.medium, size: 14)
        loadingLabel.textColor = .secondaryLabel
        loadingLabel.textAlignment = .center
        
        container.addSubview(logoImageView)
        container.addSubview(loadingLabel)
        overlay.addSubview(container)
        view.addSubview(overlay)
        
        overlay.snp.makeConstraints { $0.edges.equalToSuperview() }
        container.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(160)
        }
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24)
            $0.size.equalTo(60)
        }
        loadingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview().offset(-24)
        }
        
        UIView.animate(withDuration: 0.25) {
            overlay.alpha = 1
        }
    }
    
    func hideHoverLoading() {
        guard let overlay = view.viewWithTag(hoverLoadingTag) else { return }
        UIView.animate(withDuration: 0.25, animations: {
            overlay.alpha = 0
        }) { _ in
            overlay.removeFromSuperview()
        }
    }
}
