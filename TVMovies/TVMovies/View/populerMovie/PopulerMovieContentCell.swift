//
//  PopulerMovieContentCell.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import UIKit
import Core

class PopulerMovieContentCell: UICollectionViewCell {

    @IBOutlet weak var popularImg: UIImageView!
    @IBOutlet weak var popularTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setContentData(data: PopulerMovie){
        popularTitle.text = data.populerMovieTitle
        
        popularImg.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.populerMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
    }

}
