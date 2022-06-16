//
//  SplashPresenterTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
@testable import MoviehiveApp

class SplashPresenterTests: XCTestCase {
    
    var presenter: SplashPresenter!
    var mockView: MockSplashViewController!
    var mockInteractor: MockSplashInteractor!
    var mockRouter: MockSplashRouter!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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

    func testViewDidAppearWithNoError() throws {
        XCTAssertFalse(mockView.isInvokedInternetConnection, "Your result is true, but it should be false")
        XCTAssertFalse(mockRouter.isInvokedNavigate, "Your result is true, but it should be false")
        presenter.internetConnection(status: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.mockRouter.isInvokedNavigate, "Your result is false, but it should be true")
        }
        
    }
    func testViewDidappearWithError() throws {
        XCTAssertFalse(mockView.isInvokedInternetConnection, "Your result is true, but it should be false")
        presenter.internetConnection(status: false)
        XCTAssertTrue(mockView.isInvokedInternetConnection, "Your result is false, but it should be true")
    }

}
