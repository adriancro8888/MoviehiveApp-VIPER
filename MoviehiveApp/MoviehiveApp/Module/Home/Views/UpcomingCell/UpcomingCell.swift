//
//  UpcomingCell.swift
//  MoviehiveApp
//
//  Created by Zeynep Gizem Gürsoy on 27.04.2022.
//

import UIKit
import MoviehiveAPI
import Kingfisher

class UpcomingCell: UICollectionViewCell {

    @IBOutlet weak var releaseDate: UILabel!
   // @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(movie: Movie) {
        preprePosterImage(with: movie.posterPath)
        movieName.text = movie.title
        //movieOverview.text = movie.overview
        releaseDate.changeDateFormat(str: movie.releaseDate!)
        
    }
    private func preprePosterImage(with urlString: String?) {
        let fullPath = "https://image.tmdb.org/t/p/w200\(urlString ?? "")"
        
        let url = URL(string: fullPath)
        movieImg.kf.setImage(with: url)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
            
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
            
        layoutAttributes.frame = frame
            
        return layoutAttributes
    }

}
