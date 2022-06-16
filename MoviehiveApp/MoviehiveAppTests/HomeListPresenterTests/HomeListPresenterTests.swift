//
//  MoviehiveAppTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 24.04.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class HomeListPresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view: MockListViewController!
    var interactor: MockListInteractor!
    var router: MockListRouter!

    override func setUp(){
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }

    override func tearDown(){
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        view = nil
        presenter = nil
        interactor = nil
        router = nil
    }

    func test_viewWillAppear_InvokesRequiredViewMethods(){
        XCTAssertFalse(view.isInvokedShowLoading, "Your result is true, but it should be false")
        XCTAssertFalse(view.isInvokedHideLoading, "Your result is true, but it should be false")
        presenter.viewWillLoad()
        XCTAssertTrue(view.isInvokedShowLoading, "Your result is false, but it should be true")
    }
    
    func test_fetcMovie(){
        XCTAssertNil(presenter.nowPlayingMovie(index:0)?.title, "Filmin ismi dolu geldi")
        XCTAssertEqual(presenter.numberOfNowPlaying, 0)
        presenter.fetchMovieOutput(collectionView: .nowPlaying, result: .success(MovieListResult.response))
        XCTAssert(presenter.nowPlayingMovie(index:0)?.title == "Moonfall")
        XCTAssertEqual(presenter.numberOfNowPlaying, 20)
        
        
    }

}

extension MovieListResult {
    static var response: MovieListResponse {
        let bundle = Bundle(for: HomeListPresenterTests.self)
        let path = bundle.path(forResource: "Movies", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let movieResponse = try! JSONDecoder().decode(MovieListResponse.self, from: data)
        return movieResponse
    }
    
}
