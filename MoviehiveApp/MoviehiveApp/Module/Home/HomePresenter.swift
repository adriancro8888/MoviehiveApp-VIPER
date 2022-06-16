//
//  HomePresenter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import Foundation
import MoviehiveAPI

protocol HomePresenterProtocol: AnyObject {
    var numberOfNowPlaying: Int {get}
    var numberOfUpcoming: Int {get}
    var totalPage: Int {get}
    func viewWillLoad()
    func nowPlayingMovie(index: Int) -> Movie?
    func upcomingMovie(index: Int) -> Movie?
    func didSelectRowAt(whichCollectionView: CollectionViews, index: Int)
    func viewDidLoad()
}

final class HomePresenter: HomePresenterProtocol {

    unowned var view: HomeViewControllerProtocol?
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var nowPlayingMovies:[Movie] = []
    private var upcomingMovies:[Movie] = []
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol){
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    private func fetchMovies(){
        view?.showLoadingView()
        interactor.fetchMovies(collectionView: .upcoming)
        interactor.fetchMovies(collectionView: .nowPlaying)
        
    }
    var currentPage: Int = 0
    var totalPage: Int = 0
    
    func viewDidLoad() {
        view?.setTimer()
        view?.setSearchBar()
        view?.setTitle("Moviehive")
        view?.setUpSlider()
        view?.setUpUpcomingMovies()
    }
    
    func viewWillLoad() {
        view?.showLoadingView()
        fetchMovies()
    }
    
    var numberOfNowPlaying: Int {
        nowPlayingMovies.count
    }
    
    var numberOfUpcoming: Int {
        upcomingMovies.count
    }
    
    func nowPlayingMovie(index: Int) -> Movie? {
        guard nowPlayingMovies.count > index else {
            return nil
        }
        return nowPlayingMovies[index]
    }
    
    func upcomingMovie(index: Int) -> Movie? {
        guard upcomingMovies.count > index else {
            return nil
        }
        return upcomingMovies[index]
    }
    
    func didSelectRowAt(whichCollectionView: CollectionViews, index: Int) {
        switch whichCollectionView {
        case .upcoming:
            guard let movie = upcomingMovie(index: index) else {return}
            router.navigate(.detail(movie: movie))
        case .nowPlaying:
            guard let movie = nowPlayingMovie(index: index) else {return}
            router.navigate(.detail(movie: movie))
        }
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func fetchMovieOutput(collectionView: CollectionViews, result: MovieListResult) {
        view?.hideLoadingView()
        switch collectionView {
        case .upcoming:
            view?.hideLoadingView()
            switch result{
                
            case .success(let moviesResult):
                
                self.upcomingMovies = moviesResult.results ?? []
                view?.reloadData()
            case .failure(let error):
                print(error)
            }
        case .nowPlaying:
            view?.hideLoadingView()
            switch result{
                
            case .success(let moviesResult):
                self.nowPlayingMovies = moviesResult.results ?? []
                self.totalPage = nowPlayingMovies.count
                view?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
