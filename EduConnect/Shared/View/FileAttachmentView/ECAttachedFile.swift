//
//  ECAttachedFile.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 21.01.2026.
//

import UIKit
import UniformTypeIdentifiers

struct ECAttachedFile {
    let id: UUID = UUID()
    let name: String
    let size: Int64
    let url: URL
    let type: UTType?
    
    var formattedSize: String {
        ByteCountFormatter.string(fromByteCount: size, countStyle: .file)
    }
}
