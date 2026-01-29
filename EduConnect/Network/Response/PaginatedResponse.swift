//
//  PaginatedResponse.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 29.01.2026.
//

import Foundation

struct PaginatedResponse<T: Decodable>: Decodable {
    let data: [T]
    let meta: PaginatedMeta
}

struct PaginatedMeta: Decodable {
    let currentPage: Int
    let lastPage: Int
    let perPage: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}
