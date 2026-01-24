//
//  APIResponse.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

struct EduConnectResponse: Decodable {
    let success: Bool
    let message: String
    let errors: [String: [String]]?
}

struct EduConnectDataResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String
    let data: T?
    let errors: [String: [String]]?
}
