//
//  DetailInteractorTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class DetailInteractorTests: XCTestCase {
    var interactor: DetailInteractor!
    var mockOutput: MockDetailInteractorOutput!
    var mockMovieService: MockMovieService!

    override func setUpWithError() throws {
        mockOutput = MockDetailInteractorOutput()
        mockMovieService = MockMovieService()
        interactor = DetailInteractor(movieService: mockMovieService, output: mockOutput)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMovieDetail() throws {
        interactor.fetchMovieDetail(movieId: 414906)
        
        let result = try mockOutput.detailResult.get()
        XCTAssert(result.title != nil)
        
        let similarResult = try mockOutput.similarResult.get()
        XCTAssert(similarResult.results?.count == 20)
    }

}

class MockDetailInteractorOutput: DetailInteractorOutputProtocol {
    var detailResult: MovieDetailResult!
    var similarResult: MovieListResult!
    
    func fetchMovieDetailOutput(result: MovieDetailResult) {
        self.detailResult = result
    }
    
    func fetchSimilarMovies(result: MovieListResult) {
        self.similarResult = result
    }
    
    
}

class MockMovieService: MovieServiceProtocol {
    func fetchNowPlaying(page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        
    }
    
    func fetchUpcoming(page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        
    }
    
    func fetchMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        completionHandler(.success(MovieDetailResult.response))
    }
    
    func fetchSimilarMovie(movieId: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        completionHandler(.success(MovieListResult.response))
    }
    
    func searchMovie(query: String, page: Int, completionHandler: @escaping (MovieListResult) -> ()) {
        completionHandler(.success(MovieListResult.response))
    }
    
    
}

extension MovieDetailResult {
    static var response: MovieDetailsResponse {
        let bundle = Bundle(for: HomeListPresenterTests.self)
        let path = bundle.path(forResource: "MovieDetail", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieDetailsResponse.self, from: data)
        return movieResponse
    }
    
}
