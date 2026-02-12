//
//  ECNumberFormatter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import Foundation

struct ECNumberFormatter {
    static func toDecimalFromString(number: String) -> String {
        guard let value = Double(number) else { return number }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.usesGroupingSeparator = false

        return formatter.string(from: NSNumber(value: value)) ?? number
    }
}
