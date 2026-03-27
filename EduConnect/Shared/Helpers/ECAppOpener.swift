//
//  ECAppOpener.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 10.03.2026.
//

import UIKit

struct ECAppOpener {
    static func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
    
    static func openPrivacyURL() {
        guard let url = URL(string: "https://educonnect.kz/policy"),
              UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
