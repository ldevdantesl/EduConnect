//
//  NewsAPISubService.swift
//  EduConnect
//
//  Created by Buzurg Rakhimzoda on 8.02.2026.
//

import Foundation

protocol NewsAPISubServiceProtocol {
    func getNews(newsTypeID: String?, universityID: Int?, itemsPerPage: Int?) async throws -> [ECNews]
    func getNewsDetails(newsID: Int) async throws -> ECNews
    func getNewsTypes() async throws -> [ECNewsType]
    func getRelatedForNews(newsID: Int, limit: Int?) async throws -> [ECNews]
}

final class NewsAPISubService: NewsAPISubServiceProtocol {
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
 
    func getNews(newsTypeID: String?, universityID: Int?, itemsPerPage: Int?) async throws -> [ECNews] {
        let response: EduConnectDataResponse<[ECNews]> = try await httpClient.request(NewsEndpoints.getNews(newsTypeID: newsTypeID, universityID: universityID, itemsPerPage: itemsPerPage))
        return response.data
    }
    
    func getNewsDetails(newsID: Int) async throws -> ECNews {
        let response: EduConnectDataResponse<ECNews> = try await httpClient.request(NewsEndpoints.getNewsDetails(newsID: newsID))
        return response.data
    }
    
    func getNewsTypes() async throws -> [ECNewsType] {
        let response: EduConnectDataResponse<[ECNewsType]> = try await httpClient.request(NewsEndpoints.getNewsTypes)
        return response.data
    }
    
    func getRelatedForNews(newsID: Int, limit: Int?) async throws -> [ECNews] {
        let response: EduConnectDataResponse<[ECNews]> = try await httpClient.request(NewsEndpoints.getRelatedForNews(newsID: newsID, limit: limit))
        return response.data
    }
    
}
