//
//  ENTSubject.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

struct ENTSubject: Codable {
    let id: Int
    let name: ENTSubjectName

    func localizedName(lang: AppLanguage) -> String {
        switch lang {
        case .en: return name.en
        case .ru: return name.ru
        case .kz: return name.kz
        }
    }
}

struct ENTSubjectName: Codable {
    let ru, kz, en: String
}

extension ENTSubject {
    static let allSubjects: [ENTSubject] = Bundle.main.decode("ENTSubjects.json")
}

