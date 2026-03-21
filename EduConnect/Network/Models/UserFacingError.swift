//
//  UserFacingError.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

struct UserFacingError {
    let title: String
    let message: String
    let isRetryable: Bool
    
    static func from(_ error: APIError) -> UserFacingError {
        UserFacingError(
            title: ConstantLocalizedStrings.DEBUG.error,
            message: error.errorDescription ?? "Something went wrong",
            isRetryable: false
        )
    }
}
