//
//  TopRatedMovieContentCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core
import Kingfisher

class TopRatedMovieContentCell: UICollectionViewCell {

    @IBOutlet weak var titleTopRated: UILabel!
    @IBOutlet weak var imgTopRated: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContentData(data: TopRateMovie){
        titleTopRated.text = data.topRatedTitle
        
        imgTopRated.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.topRateImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
    }

}
