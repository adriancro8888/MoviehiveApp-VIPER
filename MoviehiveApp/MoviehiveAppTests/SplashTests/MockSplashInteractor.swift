//
//  MockSplashInteractor.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockSplashInteractor: SplashInteractorProtocol{
    var isInvokedCheckInternetConnection = false
    
    func checkInternetConnection() {
        self.isInvokedCheckInternetConnection = true
    }
    
}
