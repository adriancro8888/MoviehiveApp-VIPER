//
//  SplashInteractor.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 25.04.2022.
//

import Foundation
import MoviehiveAPI

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}
protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}
final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
    
    init(output: SplashInteractorOutputProtocol? = nil) {
        self.output = output
    }
}

extension SplashInteractor: SplashInteractorProtocol {
    func checkInternetConnection() {
        let internetStatus = NetworkManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
    
}
