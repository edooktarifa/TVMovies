//
//  UpComingMovieCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core

class UpComingMovieContentCell: UICollectionViewCell {

    @IBOutlet weak var upcomingLbl: UILabel!
    @IBOutlet weak var upcomingImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContentData(data: UpcomingMovie){
        upcomingLbl.text = data.upcomingMovieTitle
        upcomingImg.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.upcomingMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
    }

}
