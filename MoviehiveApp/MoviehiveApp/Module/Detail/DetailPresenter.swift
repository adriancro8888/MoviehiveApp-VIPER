//
//  DetailPresenter.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 28.04.2022.
//

import Foundation
import MoviehiveAPI

protocol DetailPresenterProtocol: AnyObject {
    var numberOfSimilarMovies: Int {get}
    func SimilarMovie(index: Int) -> Movie?
    func didSelectRowAt(index: Int)
    func viewDidLoad()
    func didImdbClicked()
    func addFavoriteClicked()
}

extension DetailPresenter{
    fileprivate enum Heart {
        static let addFavorite: String = "heart.fill"
        static let removeFavorite: String = "heart"
    }
}

final class DetailPresenter: DetailPresenterProtocol {
    
    unowned var view: DetailViewControllerProtocol?
    let router: DetailRouterProtocol!
    let interactor: DetailInteractorProtocol!
    
    private var movie: MovieDetailsResponse?
    private var similarMovies: [Movie] = []
    private var favoriteMovieIds = [Int]()
    
    init(view: DetailViewControllerProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    private func addFavoriteClicked(id: Int) {
        movie!.isFavorite ? favoriteMovieIds.append(id) : favoriteMovieIds.removeAll(where: { $0 == id})
        UserDefaults.standard.removeObject(forKey: "favMovies")
        UserDefaults.standard.set(favoriteMovieIds, forKey: "favMovies")
    }
    
    private func fetchMovieDetail(with movieId: Int){
        interactor.fetchMovieDetail(movieId: movieId)
    }
    
    func viewDidLoad() {
        guard let id = view?.getMovie()?.id else {return}
        fetchMovieDetail(with: id)
        view?.setUpSimilarMovies()
        view?.configureImdbImg()
        if let favMovies = UserDefaults.standard.array(forKey: "favMovies") as? [Int] {
            self.favoriteMovieIds = favMovies
            print("array:", favoriteMovieIds)
        }
    
    }
    
    var numberOfSimilarMovies: Int {
        similarMovies.count
    }
    
    func SimilarMovie(index: Int) -> Movie? {
        guard similarMovies.count > index else {
            return nil
        }
        return similarMovies[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = SimilarMovie(index: index)else {return}
        router.navigate(.detail(movie: movie))
    }
    
    func didImdbClicked() {
        guard let imdbId = movie?.imdbId else {return}
        let urlString = "https://www.imdb.com/title/\(imdbId)"
        if let url = URL(string: urlString){
            router.navigate(.openURL(url: url))
        }
        
    }
    
    func addFavoriteClicked() {
        movie!.isFavorite.toggle()
        if let id = movie?.id {
            self.addFavoriteClicked(id: id)
            let buttonType = movie!.isFavorite ? Heart.addFavorite : Heart.removeFavorite
            view?.setFavoriteButton(buttonType, isAdd: !true)
        }
    }
   
    
    
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func fetchSimilarMovies(result: MovieListResult) {
        switch result{
            
        case .success(let moviesResult):
            self.similarMovies = moviesResult.results ?? []
            view?.reloadData()
            print(similarMovies)
        case .failure(let error):
            print(error)
        }
    }
    func fetchMovieDetailOutput(result: MovieDetailResult) {
        switch result{
        case .success(let moviesResult):
            
            let fullPath = "https://image.tmdb.org/t/p/w200\(moviesResult.posterPath ?? "")"
            guard let url = URL(string: fullPath) else { return }
            view?.setDetailPage(img: url, title: moviesResult.title ?? "Null", overView: moviesResult.overview ?? "Null", rate: String(moviesResult.voteAverage ?? 0.0), date: moviesResult.releaseDate ?? "Null")
            self.movie = moviesResult
            if favoriteMovieIds.contains((movie?.id!)!){
                movie?.isFavorite = true
                let buttonType = Heart.addFavorite
                view?.setFavoriteButton(buttonType, isAdd: true)
                
            }
            print(moviesResult.title!)
        case .failure(let error):
            print(error)
        }
    }
}
