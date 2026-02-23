//
//  Data+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.02.2026.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
