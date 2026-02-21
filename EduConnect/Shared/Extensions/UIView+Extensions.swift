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

extension UIView {
    func applyFloatingShadow(
        color: UIColor = .black,
        opacity: Float = 0.15,
        radius: CGFloat = 12,
        offset: CGSize = CGSize(width: 0, height: 4),
        cornerRadius: CGFloat? = nil
    ) {
        layer.masksToBounds = false  // Important!
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        
        let cr = cornerRadius ?? layer.cornerRadius
        if bounds != .zero {
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cr
            ).cgPath
        }
    }
}

extension UIView {
    func findFirstResponder() -> UIView? {
        if isFirstResponder { return self }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}
