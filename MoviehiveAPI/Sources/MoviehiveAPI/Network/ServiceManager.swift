//
//  File.swift
//  
//
//  Created by Zeynep Gizem Gürsoy on 25.04.2022.
//

import Foundation

public protocol MovieServiceProtocol {
    
    func fetchNowPlaying(page: Int, completionHandler: @escaping (MovieListResult) -> ())
    func fetchUpcoming(page: Int, completionHandler: @escaping (MovieListResult) -> ())
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ())
    func fetchSimilarMovie(movieId: Int, completionHandler: @escaping (MovieListResult) -> ())
    func searchMovie(query: String, page: Int, completionHandler: @escaping (MovieListResult) -> ())
}

public typealias MovieListResult = Result<MovieListResponse, Error>
public typealias MovieDetailResult = Result<MovieDetailsResponse, Error>

public struct MovieService: MovieServiceProtocol{
    public init(){}
    
    public func fetchNowPlaying(page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.fetchData(request: Router.fetchNowPlaying(page: page), expecting: MovieListResponse.self, completion: completionHandler)
    }
    public func fetchUpcoming(page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.fetchData(request: Router.fetchUpcoming(page: page), expecting: MovieListResponse.self, completion: completionHandler)
    }
    public func fetchMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.fetchData(request: Router.fetchMovieDetail(movieId: movieId), expecting: MovieDetailsResponse.self, completion: completionHandler)
    }
    public func fetchSimilarMovie(movieId: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.fetchData(request: Router.fetchSimilarMovie(movieId: movieId), expecting: MovieListResponse.self, completion: completionHandler)
    }
    public func searchMovie(query: String, page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.fetchData(request: Router.searchMovie(query: query, page: page), expecting: MovieListResponse.self, completion: completionHandler)
    }
}
