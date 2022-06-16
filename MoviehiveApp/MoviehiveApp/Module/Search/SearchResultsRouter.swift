//
//  SearchResultsRouter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 30.04.2022.
//

import Foundation
import MoviehiveAPI

protocol SearchResultsRouterProtocol: AnyObject {
    func navigate(_ route: SearchRoutes)
}

enum SearchRoutes {
    case detail(movie: Movie)
}

final class SearchResultsRouter{
    weak var viewController: SearchResultsController?
    
    static func createModule() -> SearchResultsController{
        let view = SearchResultsController()
        let interactor = SearchResultsInteractor()
        let router = SearchResultsRouter()
        let presenter = SearchResultsPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}

extension SearchResultsRouter: SearchResultsRouterProtocol{
    func navigate(_ route: SearchRoutes) {
        switch route {
        case .detail(let movie):
            let detailVC = DetailRouter.createModule()
            detailVC.movie = movie
            //viewController?.show(detailVC, sender: nil)
            print(movie.title)
            print(viewController?.children)
            viewController?.presentingViewController?.navigationController?.pushViewController(detailVC, animated: true)
            
            //viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
}
