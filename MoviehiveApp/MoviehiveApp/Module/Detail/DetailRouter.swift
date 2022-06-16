//
//  DetailRouter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 28.04.2022.
//

import Foundation
import MoviehiveAPI
import UIKit

protocol DetailRouterProtocol: AnyObject{
    func navigate(_ route: DetailRoutes)
}
enum DetailRoutes {
    case detail(movie: Movie)
    case openURL(url: URL)
}

final class DetailRouter {
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController{
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    func navigate(_ route: DetailRoutes) {
        
        switch route {
        case .detail(let movie):
            let detailVC = DetailRouter.createModule()
            detailVC.movie = movie
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        case .openURL(let url):
            print(url)
            UIApplication.shared.open(url)
        }
    }
    
}
