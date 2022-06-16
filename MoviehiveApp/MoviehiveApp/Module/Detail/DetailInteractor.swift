//
//  DetailInteractor.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 28.04.2022.
//

import Foundation
import MoviehiveAPI

protocol DetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(movieId: Int)
}

protocol DetailInteractorOutputProtocol: AnyObject{
    func fetchMovieDetailOutput(result: MovieDetailResult)
    func fetchSimilarMovies(result: MovieListResult)
}

final class DetailInteractor{
    var output: DetailInteractorOutputProtocol?
    var movieService: MovieServiceProtocol
    
    init(movieService: MovieServiceProtocol = MovieService(), output: DetailInteractorOutputProtocol? = nil) {
        self.output = output
        self.movieService = movieService
    }
}

extension DetailInteractor: DetailInteractorProtocol {
    func fetchMovieDetail(movieId: Int) {
        movieService.fetchMovieDetail(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetailOutput(result: result)
        }
        movieService.fetchSimilarMovie(movieId: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchSimilarMovies(result: result)
        }
    }
}

