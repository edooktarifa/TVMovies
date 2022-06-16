//
//  SearchMovieCell.swift
//  TVMovies
//
//  Created by Phincon on 15/06/22.
//

import UIKit
import Core

class SearchMovieCell: UITableViewCell {

    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var titleSearch: UILabel!
    @IBOutlet weak var subTitleSearch: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setContentData(data: PopulerMovie){
        titleSearch.text = data.populerMovieTitle
        
        imgSearch.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(data.populerMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
    }
    
}
