//
//  File.swift
//  
//
//  Created by Zeynep Gizem Gürsoy on 25.04.2022.
//

import Foundation

//MARK: - MovieDetailsResponse
public struct MovieDetailsResponse: Codable {
    public let id: Int?
    public let imdbId: String?
    public let title: String?
    public let overview: String?
    public let posterPath: String?
    public let releaseDate: String?
    public let voteAverage: Double?
    public let tagline: String?
    public var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, tagline
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case imdbId = "imdb_id"
    }
}
