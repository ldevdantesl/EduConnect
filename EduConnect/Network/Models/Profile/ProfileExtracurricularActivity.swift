//
//  ProfileExtracurricularActivity.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ProfileExtracurricular: Decodable {
    let id: Int
    let extracurricularActivityID: Int?
    let name: String
    let description: String
    let files: [Profile.File]

    enum CodingKeys: String, CodingKey {
        case id
        case extracurricularActivityID = "extracurricular_activity_id"
        case name, description, files
    }
}
