//
//  DetailPresenterTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class DetailPresenterTests: XCTestCase {
    var presenter: DetailPresenter!
    var mockView: MockDetailViewController!
    var mockRouter: MockDetailRouter!
    var mockInteractor: MockDetailInteractor!

    override func setUpWithError() throws {
        mockView = MockDetailViewController()
        mockRouter = MockDetailRouter()
        mockInteractor = MockDetailInteractor()
        presenter = DetailPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchMovie() throws{
        XCTAssertNil(presenter.SimilarMovie(index:0)?.title, "Filmin ismi dolu geldi")
        XCTAssertEqual(presenter.numberOfSimilarMovies, 0)
        presenter.fetchSimilarMovies(result: .success(MovieListResult.response))
        XCTAssert(presenter.SimilarMovie(index:0)?.title == "Moonfall")
        XCTAssertEqual(presenter.numberOfSimilarMovies, 20)
    }


}

class MockDetailViewController: DetailViewControllerProtocol {
    var movie: Movie!
    
    func reloadData() {
    }
    
    func getMovie() -> Movie? {
        return movie
    }
    
    func setUpSimilarMovies() {
    }
    
    func setDetailPage(img: URL, title: String, overView: String, rate: String, date: String) {
    }
    
    func configureImdbImg() {
    }
    
    func setFavoriteButton(_ text: String, isAdd: Bool) {
    }
    
    
}

class MockDetailInteractor: DetailInteractorProtocol {
    
    var invokedFetchMovie = false
    
    func fetchMovieDetail(movieId: Int) {
        self.invokedFetchMovie = true
    }
    
    
}

class MockDetailRouter: DetailRouterProtocol {
    
    var isInvokedNavigate = false
    
    func navigate(_ route: DetailRoutes) {
        isInvokedNavigate = true
    }
}
