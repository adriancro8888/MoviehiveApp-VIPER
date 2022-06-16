//
//  MockListRouter.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockListRouter: HomeRouterProtocol{
    
    var isInvokedNavigate = false
    
    func navigate(_ route: HomeRoutes) {
        self.isInvokedNavigate = true
    }
    
    
}
