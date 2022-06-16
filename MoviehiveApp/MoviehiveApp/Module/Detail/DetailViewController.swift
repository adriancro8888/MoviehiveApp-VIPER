//
//  DetailViewController.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 28.04.2022.
//

import UIKit
import MoviehiveAPI
import CollectionViewExtension
import Kingfisher

protocol DetailViewControllerProtocol: AnyObject {
    func reloadData()
    func getMovie() -> Movie?
    func setUpSimilarMovies()
    func setDetailPage(img: URL, title: String, overView: String, rate: String, date: String)
    func configureImdbImg()
    func setFavoriteButton(_ text: String, isAdd: Bool)
}
class DetailViewController: BaseViewController {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imdbImg: UIImageView!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var similarMoviesCollectionView: UICollectionView!
    
    var presenter: DetailPresenterProtocol!
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifiers()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad()

    }

    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        presenter.addFavoriteClicked()
    }
}
extension DetailViewController {
    func setAccessibilityIdentifiers() {
            favoriteButton.accessibilityIdentifier = "favoriteButton"
            movieName.accessibilityIdentifier = "movieNameLabel"
        similarMoviesCollectionView.accessibilityIdentifier = "similarCollectionView"
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(presenter.numberOfSimilarMovies)
        return presenter.numberOfSimilarMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = similarMoviesCollectionView.dequeCell(cellType: SimilarMovieCell.self, indexPath: indexPath)
        if let movie = presenter.SimilarMovie(index: indexPath.row) {
            cell.cellPresenter = SimilarMovieCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    func reloadData() {
        similarMoviesCollectionView.reloadData()
    }
    
    func setDetailPage(img: URL, title: String, overView: String, rate: String, date: String) {
        self.movieImg.kf.setImage(with: img)
        self.movieName.text = title
        self.movieOverview.text = overView
        self.rate.text = rate
        self.releaseDate.changeDateFormat(str: date)
    }
    func setUpSimilarMovies() {
        similarMoviesCollectionView.dataSource = self
        similarMoviesCollectionView.delegate = self
        similarMoviesCollectionView.register(cellType: SimilarMovieCell.self)
    }
    
    func getMovie() -> Movie? {
        return movie
    }
    
    func configureImdbImg() {
        imdbImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(openUrl))
        imdbImg.addGestureRecognizer(tap)
    }
    @objc private func openUrl(){
        presenter.didImdbClicked()
    }
    
    func setFavoriteButton(_ text: String, isAdd: Bool) {
        self.favoriteButton.setImage(UIImage.init(systemName: text), for: .normal)
    }
    
}

