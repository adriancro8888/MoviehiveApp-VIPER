//
//  HomeInteractor.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import Foundation
import MoviehiveAPI

protocol HomeInteractorProtocol: AnyObject {
    func fetchMovies(collectionView: CollectionViews)
}

protocol HomeInteractorOutputProtocol: AnyObject{
    func fetchMovieOutput(collectionView: CollectionViews, result: MovieListResult)
}

final class HomeInteractor{
    var output: HomeInteractorOutputProtocol?
    var movieService: MovieServiceProtocol
    var page = 1
    
    init(movieService: MovieServiceProtocol = MovieService(), output: HomeInteractorOutputProtocol? = nil) {
        self.output = output
        self.movieService = movieService
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func fetchMovies(collectionView: CollectionViews) {
        switch collectionView {
        case .upcoming:
            movieService.fetchUpcoming(page: page) { [weak self] result in
                guard let self = self else { return }
                self.output?.fetchMovieOutput(collectionView: .upcoming, result: result)
            }
        case .nowPlaying:
            movieService.fetchNowPlaying(page: page){ [weak self] result in
                guard let self = self else { return }
                self.output?.fetchMovieOutput(collectionView: .nowPlaying, result: result)

            }
        }
    }
}
