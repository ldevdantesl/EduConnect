//
//  University.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import UIKit

struct ECUniversity: Decodable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let location: String
    let ownerShip: ECUniversityOwnership
    let price: Int
    let fields: [String]
    let faculties: Int
    let programs: Int
    let admissionInfo: ECUniversityAdmissionInfo
}

extension ECUniversity {
    static let sample: ECUniversity = .init(
        name: "Казахский национальный университет имени аль-Фараби (КазНУ)",
        location: "Астана", ownerShip: .governmental,
        price: 42_000, fields: ["Экономика", "Mенеджмент"],
        faculties: 4, programs: 50,
        admissionInfo: .init(
            budget: .init(minScore: 50, seats: 51),
            paid: .init(minScore: 31, seats: 3_384)
        )
    )
}

