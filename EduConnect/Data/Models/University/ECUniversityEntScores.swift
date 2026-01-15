//
//  ECUniversityEntScores.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 14.01.2026.
//

import Foundation

struct ECUniversityEntScores: Codable {
    let year: Int
    let budgetScore: String
    let contractScore: String

    enum CodingKeys: String, CodingKey {
        case year
        case budgetScore = "budget_score"
        case contractScore = "contract_score"
    }
}
