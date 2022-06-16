//
//  SearchResultsInteractorTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class SearchResultsInteractorTests: XCTestCase {
    
    var interactor: SearchResultsInteractor!
    var mockOutput: MockSearchInteractorOutput!
    var mockMovieService: MockMovieService!

    override func setUpWithError() throws {
        mockOutput = MockSearchInteractorOutput()
        mockMovieService = MockMovieService()
        interactor = SearchResultsInteractor(movieService: mockMovieService, output: mockOutput)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchMovies() throws {
        interactor.fetchMovies(query: "The")
        
        let result = try mockOutput.result.get()
        XCTAssert(result.results?.count == 20)
    }


}

class MockSearchInteractorOutput: SearchResultsInteractorOutputProtocol {
    var result: MovieListResult!
    func fetchMovieOutput(result: MovieListResult) {
        self.result = result
    }
    
}
