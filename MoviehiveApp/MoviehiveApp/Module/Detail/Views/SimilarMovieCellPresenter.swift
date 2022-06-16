//
//  SimilarMovieCellPresenter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 1.05.2022.
//

import Foundation
import MoviehiveAPI

protocol SimilarMovieCellPresenterProtocol: AnyObject {
    func load()
}

final class SimilarMovieCellPresenter {
    
    weak var view: SimilarMovieCellProtocol?
    private var movie: Movie
    
    init(view: SimilarMovieCellProtocol?, movie: Movie) {
        self.view = view
        self.movie = movie
    }
}

extension SimilarMovieCellPresenter: SimilarMovieCellPresenterProtocol {
    func load() {
        view?.setMovieName(movie.title ?? "")
        view?.setMovieImg(movie.posterPath ?? "")
    }
    
    
}
