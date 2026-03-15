//
//  ECLocalizedName.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECLocalizedString: Codable {
    let ru: String
    let kz: String
    
    func toCurrentLanguage() -> String {
        let localized = AppLanguage.localize(self)
        return localized.isEmpty ? self.ru : localized
    }
}
