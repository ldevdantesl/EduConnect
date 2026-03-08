//
//  ECNews.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import Foundation

struct ECNews: Identifiable, Decodable {
    struct University: Decodable {
        let id: Int
        let name: ECLocalizedString
        let logoURL: String?
    }
    
    let id: Int
    let universityID: Int
    let university: University
    let newsTypeID: Int
    let newsType: ECNewsType
    let newsCategoryID: Int
    let newsCategory: ECNewsType
    let title: ECLocalizedString
    let shortDescription: ECLocalizedString
    let description: ECLocalizedString
    let mainImage: String
    let mainImageURL: String
    let previewImage: String
    let previewImageURL: String
    let isActive: Bool
    let sortOrder: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case universityID = "university_id"
        case university
        case newsTypeID = "news_type_id"
        case newsType = "news_type"
        case newsCategoryID = "news_category_id"
        case newsCategory = "news_category"
        case title
        case shortDescription = "short_description"
        case description
        case mainImage = "main_image"
        case mainImageURL = "main_image_url"
        case previewImage = "preview_image"
        case previewImageURL = "preview_image_url"
        case isActive = "is_active"
        case sortOrder = "sort_order"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
