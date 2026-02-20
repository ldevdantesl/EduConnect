//
//  EndpointAuth.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 19.02.2026.
//

import Foundation

enum EndpointAuth {
    case apiKey(apiKey: String?)
    case bearer(token: String?)
    case none
}
