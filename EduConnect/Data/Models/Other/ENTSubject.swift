//
//  ENTSubject.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 22.01.2026.
//

import Foundation

struct ENTSubject: Codable {
    let id: Int
    let name: ECLocalizedString
}

extension ENTSubject {
    static let allSubjects: [ENTSubject] = Bundle.main.decode("ENTSubjects.json")
}

