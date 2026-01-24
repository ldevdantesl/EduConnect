//
//  ECPaddedLabel.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit

final class ECPaddedLabel: UILabel {
    var padding: UIEdgeInsets
    var makeCircular: Bool = false
    
    override func drawText(in rect: CGRect) {
        if makeCircular {
            let originalSize = super.intrinsicContentSize
            let x = (rect.width - originalSize.width) / 2
            let y = (rect.height - originalSize.height) / 2
            let centeredRect = CGRect(x: x, y: y, width: originalSize.width, height: originalSize.height)
            super.drawText(in: centeredRect)
        } else {
            let insetRect = rect.inset(by: padding)
            super.drawText(in: insetRect)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let originalSize = super.intrinsicContentSize
        let width = originalSize.width + padding.left + padding.right
        let height = originalSize.height + padding.top + padding.bottom
        
        if makeCircular {
            let size = max(width, height)
            return CGSize(width: size, height: size)
        }
        
        return CGSize(width: width, height: height)
    }
    
    init(padding: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)) {
        self.padding = padding
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if makeCircular {
            self.layer.cornerRadius = bounds.height / 2
        }
    }
}
