//
//  KeyboardAdjustableCollectionView.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 5.03.2026.
//

import UIKit

final class KeyboardAdjustableCollectionView: UICollectionView {
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil {
            setupKeyboardObservers()
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let window
        else { return }
        
        let bottomInset = frame.height - window.safeAreaInsets.bottom + 50
        UIView.animate(withDuration: duration) {
            self.contentInset.bottom = bottomInset
            self.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        else { return }
        
        UIView.animate(withDuration: duration) {
            self.contentInset.bottom = 0
            self.verticalScrollIndicatorInsets.bottom = 0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
