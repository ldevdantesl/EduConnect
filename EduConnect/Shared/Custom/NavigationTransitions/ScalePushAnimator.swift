//
//  ScalePushAnimator.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

final class ScalePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using ctx: UIViewControllerContextTransitioning?) -> TimeInterval { return 1 }

    func animateTransition(using ctx: UIViewControllerContextTransitioning) {
        guard let toView = ctx.view(forKey: .to) else { return }

        let container = ctx.containerView
        toView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        toView.alpha = 0
        container.addSubview(toView)

        UIView.animate(
            withDuration: transitionDuration(using: ctx),
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.6
        ) {
            toView.transform = .identity
            toView.alpha = 1
        } completion: { _ in
            ctx.completeTransition(true)
        }
    }
}
