//
//  ECUniversityAdmission.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 13.01.2026.
//

import Foundation

struct ECUniversityAdmissionInfo: Decodable {
    let budget: ECUniversityAdmissionTrack
    let paid: ECUniversityAdmissionTrack
}

struct ECUniversityAdmissionTrack: Decodable {
    let minScore: Int
    let seats: Int
}
