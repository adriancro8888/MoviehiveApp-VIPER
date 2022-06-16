//
//  SearchResultsInteractor.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 30.04.2022.
//

import Foundation
import MoviehiveAPI

protocol SearchResultsInteractorProtocol: AnyObject {
    func fetchMovies(query: String)
}

protocol SearchResultsInteractorOutputProtocol: AnyObject{
    func fetchMovieOutput(result: MovieListResult)
}

final class SearchResultsInteractor{
    var output: SearchResultsInteractorOutputProtocol?
    var movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService(), output: SearchResultsInteractorOutputProtocol? = nil) {
        self.output = output
        self.movieService = movieService
    }
}

extension SearchResultsInteractor: SearchResultsInteractorProtocol{
    
    func fetchMovies(query: String) {
        movieService.searchMovie(query: query, page: 1){ [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieOutput(result: result)
        }
    }
}


