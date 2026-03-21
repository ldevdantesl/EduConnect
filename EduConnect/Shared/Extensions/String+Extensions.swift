//
//  String+Extensions.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 30.01.2026.
//

import Foundation

extension String {
    func extractYouTubeID() -> String? {
        let patterns = [
            "(?<=youtu.be/)([a-zA-Z0-9_-]{11})",
            "(?<=v=)([a-zA-Z0-9_-]{11})",
            "(?<=embed/)([a-zA-Z0-9_-]{11})",
            "(?<=shorts/)([a-zA-Z0-9_-]{11})"
        ]
        
        for pattern in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern),
               let match = regex.firstMatch(in: self, range: NSRange(self.startIndex..., in: self)),
               let range = Range(match.range(at: 1), in: self) {
                return String(self[range])
            }
        }
        
        return nil
    }
    
    var acceptingNewLines: String {
        self.replacingOccurrences(of: "\\n", with: "\n")
    }
}
