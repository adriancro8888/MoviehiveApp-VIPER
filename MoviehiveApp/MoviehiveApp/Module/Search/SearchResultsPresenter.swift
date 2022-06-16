//
//  SearchResultsPresenter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 30.04.2022.
//

import Foundation
import MoviehiveAPI

protocol SearchResultsPresenterProtocol: AnyObject {
    var numberOfMovies: Int {get}
    func searchedMovie(index: Int) -> Movie?
    func didSelectRowAt(index: Int)
    func updateResults(query: String)
    func removeMovies()
    func viewDidLoad()
}

final class SearchResultsPresenter: SearchResultsPresenterProtocol{
    
    unowned var view: SearchResultsControllerProtocol?
    let router: SearchResultsRouterProtocol!
    let interactor: SearchResultsInteractorProtocol!
    
    init(view: SearchResultsControllerProtocol, router: SearchResultsRouterProtocol, interactor: SearchResultsInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    private var searchedMovies:[Movie] = []
    
    var numberOfMovies: Int {
        searchedMovies.count
    }
    
    func searchedMovie(index: Int) -> Movie? {
        guard searchedMovies.count > index else {
            return nil
        }
        return searchedMovies[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = searchedMovie(index: index) else {return}
        router.navigate(.detail(movie: movie))
    }
    
    func updateResults(query: String) {
        if query.count > 1 {
            interactor.fetchMovies(query: query)
        }else {
            searchedMovies.removeAll()
            view?.reloadData()
        }
        
    }
    
    func removeMovies() {
        self.searchedMovies.removeAll()
    }
    
    func viewDidLoad() {
        view?.setView()
    }
    
}

extension SearchResultsPresenter: SearchResultsInteractorOutputProtocol{
    func fetchMovieOutput(result: MovieListResult) {
        
        switch result{
        case .success(let moviesResult):
            self.searchedMovies = moviesResult.results ?? []
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
        
    }
    
}
