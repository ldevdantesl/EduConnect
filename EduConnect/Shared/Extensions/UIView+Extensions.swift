//
//  UIView+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.02.2026.
//

import UIKit

extension UIView {
    func animateTap(onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            } completion: { _ in
                onCompletion?()
            }
        }
    }
}
