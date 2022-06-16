//
//  SplashInteractorTests.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import XCTest
import MoviehiveAPI
@testable import MoviehiveApp

class SplashInteractorTests: XCTestCase {
    
    var interactor: SplashInteractor!
    var mockOutput: MockSplashInteractorOutput!

    override func setUpWithError() throws {
        mockOutput = MockSplashInteractorOutput()
        interactor = SplashInteractor(output: mockOutput)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInternetConnection() throws {
        XCTAssertFalse(mockOutput.noInternet, "Your result is true, but it should be false")
        interactor.checkInternetConnection()
        XCTAssertFalse(mockOutput.noInternet, "Your result is true, but it should be false")
    }

}

class MockSplashInteractorOutput: SplashInteractorOutputProtocol {
    var noInternet = false
    
    func internetConnection(status: Bool) {
        self.noInternet = false
    }

}
