//
//  ErrorService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

protocol ErrorServiceProtocol {
    func handle(_ error: any Error) -> UserFacingError
    func shouldRetry(_ error: APIError) -> Bool
    func shouldLogout(_ error: APIError) -> Bool
}

final class ECErrorService: ErrorServiceProtocol {
    
    var onUnauthorized: (() -> Void)?
    
    func handle(_ error: any Error) -> UserFacingError {
        #if DEBUG
        print("🔴 API Error: \(error)")
        #endif
        
        guard let apiError = error as? APIError else {
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.error,
                message: error.localizedDescription,
                isRetryable: false
            )
        }
        
        
        switch apiError {
        case .noConnection:
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.noConnection,
                message: ConstantLocalizedStrings.DEBUG.networkLost,
                isRetryable: true
            )
            
        case .timeout:
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.limitPassed,
                message: ConstantLocalizedStrings.DEBUG.noResponseTryLater,
                isRetryable: true
            )
            
        case .statusCode(let code, _) where code == 401:
            onUnauthorized?()
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.sessionExpired,
                message: ConstantLocalizedStrings.DEBUG.logInAgain,
                isRetryable: false
            )
            
        case .statusCode(let code, _) where code >= 500:
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.serverError,
                message: ConstantLocalizedStrings.DEBUG.tryLater,
                isRetryable: true
            )
            
        case .custom(let message, let errors):
            let fieldDetails = errors?.values.flatMap { $0 }.joined(separator: "\n")
            let fullMessage = [message, fieldDetails].compactMap { $0 }.joined(separator: "\n")
            return UserFacingError(
                title: ConstantLocalizedStrings.DEBUG.error,
                message: fullMessage,
                isRetryable: false
            )
        
            
        default:
            return UserFacingError.from(apiError)
        }
    }
    
    func shouldRetry(_ error: APIError) -> Bool {
        switch error {
        case .noConnection, .timeout:
            return true
        case .statusCode(let code, _) where code >= 500:
            return true
        default:
            return false
        }
    }
    
    func shouldLogout(_ error: APIError) -> Bool {
        if case .statusCode(401, _) = error {
            return true
        }
        return false
    }
}
