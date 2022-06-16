//
//  SimilarMovieCell.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 28.04.2022.
//

import UIKit
import MoviehiveAPI

protocol SimilarMovieCellProtocol: AnyObject {
    func setMovieName(_ text: String)
    func setMovieImg(_ imageUrl: String)
}
class SimilarMovieCell: UICollectionViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    var cellPresenter: SimilarMovieCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func preprePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        movieImg.kf.indicatorType = .activity
        
        let url = URL(string: fullPath)
        movieImg.kf.setImage(with: url)
    }

}

extension SimilarMovieCell: SimilarMovieCellProtocol{
    func setMovieName(_ text: String) {
        self.movieName.text = text
    }
    
    func setMovieImg(_ imageUrl: String) {
        preprePosterImage(with: imageUrl)
    }
    
    
}
