//
//  NewsEndpoints.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 7.02.2026.
//

import Foundation

enum NewsEndpoints: Endpoint {
    case getNews(newsTypeID: String?, universityID: Int?, itemsPerPage: Int?, page: Int?)
    case getNewsDetails(newsID: Int)
    case getNewsTypes
    case getRelatedForNews(newsID: Int, limit: Int?)
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .getNews: return "/news"
        case .getNewsDetails(let newsID): return "/news/\(newsID)"
        case .getNewsTypes: return "/news-types"
        case .getRelatedForNews(let newsID, _): return "/news/\(newsID)/related"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getNews(let newsTypeID, let universityID, let itemsPerPage, let page):
            var items: [URLQueryItem] = []
            if let newsTypeID {
                items.append(.init(name: "news_type_id", value: newsTypeID))
            }
            if let universityID {
                items.append(.init(name: "university_id", value: "\(universityID)"))
            }
            if let itemsPerPage {
                items.append(.init(name: "per_page", value: "\(itemsPerPage)"))
            }
            if let page {
                items.append(.init(name: "page", value: "\(page)"))
            }
            return items
        case .getRelatedForNews(_, let limit):
            if let limit {
                return [.init(name: "limit", value: limit.description)]
            } else { return .none }
        default: return .none
        }
    }
}
