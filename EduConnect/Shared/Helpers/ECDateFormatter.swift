//
//  ECDateFormatter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import Foundation

struct ECDateFormatter {
    
    enum FormatType {
        case onlyDate
        case dateWithTime
        
        var template: String {
            switch self {
            case .onlyDate: return "d MMM yyyy"
            case .dateWithTime: return "d MMM yyyy HH:mm"
            }
        }
    }
    
    static func formatISODate(_ date: String, formatType: FormatType = .onlyDate) -> String {
        let isoString = date
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoString) else { return date }

        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.setLocalizedDateFormatFromTemplate(formatType.template)

        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
