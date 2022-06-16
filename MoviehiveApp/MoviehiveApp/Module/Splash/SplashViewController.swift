//
//  SplashViewController.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 25.04.2022.
//

import UIKit


protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}
class SplashViewController: BaseViewController {
    
    var presenter: SplashPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidAppear()
    }

}

extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlert(title: "Error", message: "No Internet Connection, Please check your connection!")
    }
}
