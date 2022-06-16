//
//  DetailMovieViewController.swift
//  TVMovies
//
//  Created by Phincon on 14/06/22.
//

import UIKit
import Core
import Kingfisher

enum MovieType {
    case topRateMovie
    case upcomingMovie
    case nowPlayingMovie
    case populerMovie
}

class DetailMovieViewController: UIViewController {
    
    var typeMovie : MovieType = .upcomingMovie
    
    var rateMovie: TopRateMovie?
    var upcomingMovie: UpcomingMovie?
    var nowPlayingMovie: NowPlayingMovie?
    var populerMovie: PopulerMovie?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch typeMovie {
        case .topRateMovie:
            detailTitle.text = rateMovie?.topRatedTitle
            detailImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(rateMovie?.topRateImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
            overview.text = rateMovie?.overview
            title = rateMovie?.topRatedTitle
        case .upcomingMovie:
            detailTitle.text = upcomingMovie?.upcomingMovieTitle
            detailImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(upcomingMovie?.upcomingMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
            overview.text = upcomingMovie?.overview
            title = upcomingMovie?.upcomingMovieTitle
        case .nowPlayingMovie:
            detailTitle.text = nowPlayingMovie?.nowPlayingMovieTitle
            detailImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(nowPlayingMovie?.nowPlayingMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
            overview.text = nowPlayingMovie?.overview
            title = nowPlayingMovie?.nowPlayingMovieTitle
        case .populerMovie:
            detailTitle.text = populerMovie?.populerMovieTitle
            detailImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500\(populerMovie?.populerMovieImage ?? "")"), placeholder: UIImage(named: "NoImage"), options: nil, completionHandler: nil)
            overview.text = populerMovie?.overview
            title = populerMovie?.populerMovieTitle
        }
    }
    
}
