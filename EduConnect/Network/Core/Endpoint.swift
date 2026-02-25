//
//  Endpoint.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 23.01.2026.
//

import Foundation

enum ContentType {
    case urlEncoded
    case multipart
}

struct MultipartField {
    let name: String
    let value: MultipartValue
}

enum MultipartValue {
    case text(String?)
    case file(data: Data, fileName: String, mimeType: String)
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var auth: EndpointAuth { get }
    var body: Data? { get }
    var contentType: ContentType { get }
    var multipartFields: [MultipartField]? { get }
}

extension Endpoint {
    var baseURL: String { APIConstants.baseURL }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var auth: EndpointAuth { .none }
    var body: Data? { nil }
    var contentType: ContentType { .urlEncoded }
    var multipartFields: [MultipartField]? { nil }
}
