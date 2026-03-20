//
//  UniversityTypeConverter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.03.2026.
//

import Foundation

struct UniversityTypeConverter {
    static func toCurrentLanguage(name: String) -> String {
        let current = AppLanguage.current()
        switch current {
        case .en:
            if name == "Государственный" {
                return ConstantLocalizedStrings.Words.governmentalKey
            } else {
                return ConstantLocalizedStrings.Words.privateKey
            }
        default: return name
        }
    }
}
