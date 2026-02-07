//
//  ECProgramCategories.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 28.01.2026.
//

import Foundation

struct ECProgramCategory: Identifiable, Decodable {
    let id: Int
    let code: String
    let name: ECLocalizedString
    let icon: String
    let iconURL: String?
    let isActive: Bool
    let sortOrder, programsCount: Int

    enum CodingKeys: String, CodingKey {
        case id, code, name, icon
        case iconURL = "icon_url"
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case programsCount = "programs_count"
    }
}
