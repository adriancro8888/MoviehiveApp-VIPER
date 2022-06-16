//
//  MockSearchRouter.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockSearchRouter: SearchResultsRouterProtocol{
    var isInvokedNavigate = false
    func navigate(_ route: SearchRoutes) {
        self.isInvokedNavigate = true
    }
}
