//
//  DetailViewControllerTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class DetailViewControllerTests: XCTestCase {
    
    var mockPresenter: MockDetailPresenter!
    var view: DetailViewController!

    override func setUpWithError() throws {
        mockPresenter = MockDetailPresenter()
        view = DetailViewController()
    }
    func testFavoriteButton() throws {
        XCTAssertFalse(mockPresenter.isInvokedFavorite, "Your result is true, but it should be false")
        mockPresenter.addFavoriteClicked()
        XCTAssertTrue(mockPresenter.isInvokedFavorite, "Your result is false, but it should be true")
    }

}

class MockDetailPresenter: DetailPresenterProtocol {
    var isInvokedFavorite = false
    var numberOfSimilarMovies: Int = 0
    var movie : Movie?
    
    func SimilarMovie(index: Int) -> Movie? {
        return movie
    }
    
    func didSelectRowAt(index: Int) {
    }
    
    func viewDidLoad() {
    }
    
    func didImdbClicked() {
    }
    
    func addFavoriteClicked() {
        self.isInvokedFavorite = !self.isInvokedFavorite
    }
    
    
}
