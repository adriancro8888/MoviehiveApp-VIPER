//
//  MockListViewController.swift
//  MoviehiveAppTests
//
//  Created by Zeynep Gizem Gürsoy on 4.05.2022.
//

import Foundation
@testable import MoviehiveApp

final class MockListViewController: HomeViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var isInvokedHideLoading = false
    
    func reloadData() {}
    
    func showLoadingView() {
        self.isInvokedShowLoading = true
    }
    
    func hideLoadingView() {
        self.isInvokedHideLoading = true
    }
    
    func setUpSlider() {}
    
    func setUpUpcomingMovies() {}
    
    func setTitle(_ title: String) {}
    
    func setTimer() {}
    
    func setSearchBar() {}
    
    
}
