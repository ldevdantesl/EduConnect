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
        let code = Bundle.main.preferredLocalizations.first
        
        switch code {
        case "ru": return .ru
        case "kk": return .kz
        default: return .en
        }
    }
    
    static func localize(_ localizedString: ECLocalizedString) -> String {
        let current = current()
        switch current {
        case .kz: return localizedString.kz
        default: return localizedString.ru
        }
    }
}
