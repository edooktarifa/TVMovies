//
//  ViewController.swift
//  TVMovies
//
//  Created by Phincon on 09/06/22.
//

import UIKit
import NetworkServices
import RxSwift
import Core

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var vm: TopRateMovieVM!
    var vmUpcoming: UpComingMovieVM!
    var vmNowPlaying: NowPlayingMovieVM!
    var vmPopulerMovie: PopulerMovieVM!
    
    let searchController = UISearchController()
    
    var disposeBag = DisposeBag()
    
    private var dataSource: ViewControllerDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie"
        setupSearch()
    }
    
    func setupSearch(){
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm = ListMovieInjection.shared.container.resolve(TopRateMovieVM.self)!
        vmUpcoming = UpcomingMovieInjection.shared.container.resolve(UpComingMovieVM.self)!
        vmNowPlaying = NowPlayingMovieInjection.shared.container.resolve(NowPlayingMovieVM.self)!
        vmPopulerMovie = PopulerMovieInjection.shared.container.resolve(PopulerMovieVM.self)!
        
        dataSource = ViewControllerDataSource(vm: vm, vmUpcoming: vmUpcoming, vmNowPlaying: vmNowPlaying, vmPopulerMovie: vmPopulerMovie, collectionView: collectionView, view: self)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
    }
}


extension ViewController:  UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate{
    
    func updateSearchResults(for searchController: UISearchController) { }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let vc = SearchMovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
