//
//  ECAttachedImage.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 11.03.2026.
//

import UIKit

struct ECAttachedImage {
    let id: UUID = UUID()
    let image: UIImage
    let name: String

    var jpegData: Data? {
        image.jpegData(compressionQuality: 0.8)
    }
}
