//
//  ErrorService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

protocol ErrorServiceProtocol {
    func handle(_ error: APIError) -> UserFacingError
    func shouldRetry(_ error: APIError) -> Bool
    func shouldLogout(_ error: APIError) -> Bool
}

final class ECErrorService: ErrorServiceProtocol {
    
    var onUnauthorized: (() -> Void)?
    
    func handle(_ error: APIError) -> UserFacingError {
        #if DEBUG
        print("🔴 API Error: \(error)")
        #endif
        
        switch error {
        case .noConnection:
            return UserFacingError(
                title: "Нет соединения",
                message: "Проверьте подключение к интернету",
                isRetryable: true
            )
            
        case .timeout:
            return UserFacingError(
                title: "Превышено время ожидания",
                message: "Сервер не отвечает. Попробуйте позже",
                isRetryable: true
            )
            
        case .statusCode(let code, _) where code == 401:
            onUnauthorized?()
            return UserFacingError(
                title: "Сессия истекла",
                message: "Войдите снова",
                isRetryable: false
            )
            
        case .statusCode(let code, _) where code >= 500:
            return UserFacingError(
                title: "Ошибка сервера",
                message: "Попробуйте позже",
                isRetryable: true
            )
            
        case .custom(let message, _):
            return UserFacingError(
                title: "Ошибка",
                message: message,
                isRetryable: false
            )
            
        default:
            return UserFacingError.from(error)
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
