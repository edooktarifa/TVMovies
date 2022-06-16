//
//  NowPlayingMovieContentCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core

class NowPlayingMovieContentCell: UICollectionViewCell {

    @IBOutlet weak var nowPlayingImg: UIImageView!
    @IBOutlet weak var nowPlayingTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContentData(data: NowPlayingMovie){
        nowPlayingTitle.text = data.nowPlayingMovieTitle
        nowPlayingImg.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.nowPlayingMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
    }
}
