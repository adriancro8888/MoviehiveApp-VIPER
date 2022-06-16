//
//  MockSplashViewController.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockSplashViewController: SplashViewControllerProtocol {
    
    var isInvokedInternetConnection = false
    
    func noInternetConnection() {
        self.isInvokedInternetConnection = true
    }

}
