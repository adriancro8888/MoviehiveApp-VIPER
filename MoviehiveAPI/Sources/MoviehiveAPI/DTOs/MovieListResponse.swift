//
//  File.swift
//  
//
//  Created by Zeynep Gizem Gürsoy on 25.04.2022.
//

import Foundation

//MARK: - MovieListResponse
public struct MovieListResponse: Decodable {
    public let page: Int?
    public let results: [Movie]?
    public let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page,results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//MARK: - Movies
public struct Movie: Decodable {
    public let id: Int?
    public let title: String?
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
