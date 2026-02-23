//
//  ECDateFormatter.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.02.2026.
//

import Foundation

struct ECDateFormatter {
    static func formatISODate(_ date: String) -> String {
        let isoString = date
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: isoString) else { return date }

        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.setLocalizedDateFormatFromTemplate("d MMM yyyy")

        let formattedDate = formatter.string(from: date)
        return formattedDate
    }
}
