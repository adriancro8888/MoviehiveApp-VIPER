//
//  NowPlayingCell.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import UIKit
import MoviehiveAPI
import Kingfisher

class NowPlayingCell: UICollectionViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: Movie) {
        preprePosterImage(with: movie.posterPath)
        movieName.text = movie.title
        
    }
    private func preprePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        
        let url = URL(string: fullPath)
        movieImg.kf.setImage(with: url)
    }

}
