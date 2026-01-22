//
//  AppLanguageHelper.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

enum AppLanguage: String {
    case en, ru, kz

    static func current() -> AppLanguage {
        let code = Locale.preferredLanguages.first?
            .components(separatedBy: "-")
            .first

        switch code {
        case "ru": return .ru
        case "kk": return .kz
        default: return .en
        }
    }
}
