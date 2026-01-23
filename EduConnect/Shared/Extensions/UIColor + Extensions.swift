//
//  UIColor + Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import UIKit

extension UIColor {
    static func hex(_ hex: String) -> UIColor {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hex = hex.replacingOccurrences(of: "#", with: "")

        guard hex.count == 6,
              let value = Int(hex, radix: 16) else {
            return .clear
        }

        let r = CGFloat((value >> 16) & 0xFF) / 255
        let g = CGFloat((value >> 8) & 0xFF) / 255
        let b = CGFloat(value & 0xFF) / 255

        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}
