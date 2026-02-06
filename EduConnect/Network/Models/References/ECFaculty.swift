//
//  ECFaculty.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECFaculty: Decodable {
    let id: Int
    let name: ECLocalizedString
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name, image
    }
}
