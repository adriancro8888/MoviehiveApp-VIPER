//
//  MockListInteractor.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockListInteractor: HomeInteractorProtocol {
    
    var invokedFetchMovie = false
    var invokedFetchMovieCount = 0
    
    func fetchMovies(collectionView: CollectionViews) {
        self.invokedFetchMovie = true
        self.invokedFetchMovieCount += 1
    }
    
}
