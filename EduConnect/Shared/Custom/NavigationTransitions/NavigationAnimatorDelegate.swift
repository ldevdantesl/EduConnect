//
//  NavigationAnimatorDelegate.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 9.01.2026.
//

import UIKit

final class NavigationAnimatorDelegate: NSObject, UINavigationControllerDelegate {

    private let pushAnimator = ScalePushAnimator()

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        operation == .push ? pushAnimator : nil
    }
}
