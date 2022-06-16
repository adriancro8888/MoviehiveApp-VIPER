//
//  SearchResultsPresenterTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class SearchResultsPresenterTests: XCTestCase {
    
    var presenter: SearchResultsPresenter!
    var mockView: MockSearchViewController!
    var mockInteractor: MockSearchInteractor!
    var mockRouter: MockSearchRouter!


    override func setUpWithError() throws {
        super.setUp()
        mockView = .init()
        mockInteractor = .init()
        mockRouter = .init()
        presenter = .init(view: mockView, router: mockRouter, interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockView = nil
        presenter = nil
        mockInteractor = nil
        mockRouter = nil
    }

    func testFetchMovies() throws {
        XCTAssertNil(presenter.searchedMovie(index:0)?.title, "Filmin ismi dolu geldi")
        XCTAssertEqual(presenter.numberOfMovies, 0)
        presenter.fetchMovieOutput(result: .success(MovieListResult.response))
        XCTAssert(presenter.searchedMovie(index:0)?.title == "Moonfall")
        XCTAssertEqual(presenter.numberOfMovies, 20)
    }

}
