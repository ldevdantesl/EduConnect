//
//  ECCity.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECCity: Decodable {
    let id: Int
    let name: ECLocalizedString

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
