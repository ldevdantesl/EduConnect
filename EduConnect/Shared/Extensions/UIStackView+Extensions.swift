//
//  UIStackView+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 15.03.2026.
//

import UIKit

extension UIStackView {
    func clearArrangedSubviews() {
        self.arrangedSubviews.forEach { $0.removeFromSuperview(); self.removeArrangedSubview($0) }
    }
}
