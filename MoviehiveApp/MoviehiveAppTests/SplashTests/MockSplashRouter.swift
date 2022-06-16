//
//  MockSplashRouter.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockSplashRouter: SplashRouterProtocol{
    var isInvokedNavigate = false
    func navigate(_ route: SplashRoutes) {
        self.isInvokedNavigate = true
    }

}
