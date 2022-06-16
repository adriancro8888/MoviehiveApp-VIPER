//
//  MockSearchInteractor.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockSearchInteractor: SearchResultsInteractorProtocol{
    
    var invokedFetchMovie = false
    var invokedFetchMovieCount = 0
    
    func fetchMovies(query: String) {
        self.invokedFetchMovie = true
        self.invokedFetchMovieCount += 1
    }
    
}
