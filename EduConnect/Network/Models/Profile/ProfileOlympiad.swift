//
//  ProfileOlympiad.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 20.02.2026.
//

import Foundation

struct ProfileOlympiad: Decodable {
    let id: Int
    let olympiadTypeID: Int
    let olympiadTypeName: String
    let olympiadPlaceID: Int
    let olympiadPlaceName: String
    let year: Int
    let files: [Profile.File]

    enum CodingKeys: String, CodingKey {
        case id
        case olympiadTypeID = "olympiad_type_id"
        case olympiadTypeName = "olympiad_type_name"
        case olympiadPlaceID = "olympiad_place_id"
        case olympiadPlaceName = "olympiad_place_name"
        case year, files
    }
}

