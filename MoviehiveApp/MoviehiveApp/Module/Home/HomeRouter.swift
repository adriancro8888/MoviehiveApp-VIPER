//
//  HomeRouter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import Foundation
import MoviehiveAPI

protocol HomeRouterProtocol: AnyObject{
    func navigate(_ route: HomeRoutes)
}
enum HomeRoutes {
    case detail(movie: Movie)
}

final class HomeRouter{
    weak var viewController: HomeViewController?
    
    static func createModule() -> HomeViewController{
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = DetailRouter.createModule()
            detailVC.movie = movie
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
