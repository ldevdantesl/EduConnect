//
//  ECPaddedLabel.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit

final class ECPaddedLabel: UILabel {
    var padding: UIEdgeInsets
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom
        )
    }
    
    init(padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)) {
        self.padding = padding
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
