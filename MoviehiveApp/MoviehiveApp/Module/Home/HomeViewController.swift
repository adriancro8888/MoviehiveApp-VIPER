//
//  HomeViewController.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import UIKit
import CollectionViewExtension
import MoviehiveAPI

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setUpSlider()
    func setUpUpcomingMovies()
    func setTitle(_ title: String)
    func setTimer()
    func setSearchBar()
}
enum CollectionViews {
    case upcoming
    case nowPlaying
}

class HomeViewController: BaseViewController, LoadingShowable, UISearchControllerDelegate {
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    
    var presenter: HomePresenterProtocol!
    //for pageControl
    var timer = Timer()
    var counter = 0
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    var searchVC: SearchResultsController?
    var searchController: UISearchController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setAccessibilityIdentifiers()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillLoad()
    }
    
    
    
    @objc func changeSlide(){
        if counter < presenter.totalPage {
            let indexPath = IndexPath(item: counter, section: 0)
            nowPlayingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            currentPage = counter
            counter += 1
        }else {
            counter = 0
            currentPage = counter
            let indexPath = IndexPath(item: counter, section: 0)
            nowPlayingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nowPlayingCollectionView {
            return presenter.numberOfNowPlaying
        }else {
            return presenter.numberOfUpcoming
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == nowPlayingCollectionView {
            let cell = collectionView.dequeCell(cellType: NowPlayingCell.self, indexPath: indexPath)
            if let movie = presenter.nowPlayingMovie(index: indexPath.row) {
                cell.configure(movie: movie)
            }
            return cell
        }else {
            let cell = collectionView.dequeCell(cellType: UpcomingCell.self, indexPath: indexPath)
            if let movie = presenter.upcomingMovie(index: indexPath.row) {
                cell.configure(movie: movie)
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == nowPlayingCollectionView{
            presenter.didSelectRowAt(whichCollectionView: .nowPlaying, index: indexPath.row)
        }else{
            presenter.didSelectRowAt(whichCollectionView: .upcoming, index: indexPath.row)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        counter = currentPage
    }
    
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == nowPlayingCollectionView {
            return CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 0.25)
        }else {
            return CGSize(width: self.view.bounds.width - 20, height: self.view.bounds.height * 0.25 )
        }
        
    }
}
extension HomeViewController {
    func setAccessibilityIdentifiers() {
            upcomingCollectionView.accessibilityIdentifier = "upcomingCollectionView"
            nowPlayingCollectionView.accessibilityIdentifier = "nowPlayingCollectionView"
    }
}
extension HomeViewController: HomeViewControllerProtocol {
    func setSearchBar() {
        let searchVC = SearchResultsRouter.createModule()
        let searchController = UISearchController(searchResultsController: searchVC)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = .default
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.layer.borderWidth = 2;
        searchController.searchBar.layer.borderColor = UIColor.clear.cgColor

        
        searchController.searchResultsUpdater = searchVC
        searchController.searchBar.delegate = searchVC
        searchController.isActive = true
        searchController.delegate = self
        self.definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        
        self.searchVC = searchVC
        self.searchController = searchController

    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeSlide), userInfo: nil, repeats: true)
    }
    
    func setUpSlider() {
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.register(cellType: NowPlayingCell.self)
        
    }
    
    func setUpUpcomingMovies() {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.estimatedItemSize = CGSize(width: upcomingCollectionView.frame.width, height: self.view.bounds.height * 0.25)
        upcomingCollectionView.collectionViewLayout = collectionFlowLayout
        upcomingCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        upcomingCollectionView.register(cellType: UpcomingCell.self)
    }
    
    func setTitle(_ title: String) {
        self.title = title
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.orange
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    }
    
    func reloadData() {
        pageControl.numberOfPages = presenter.totalPage
        nowPlayingCollectionView.reloadData()
        upcomingCollectionView.reloadData()
    }
    
    func showLoadingView() {
        //showLoadingView()
    }
    
    func hideLoadingView() {
        //hideLoadingView()
    }
    
    
}
