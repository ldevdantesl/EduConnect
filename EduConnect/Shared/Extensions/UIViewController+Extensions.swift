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
        let toast = UILabel()
        toast.text = message
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
            $0.height.equalTo(44)
        }
    
        UIView.animate(withDuration: 0.3){
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
