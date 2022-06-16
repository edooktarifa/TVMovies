//
//  ViewControllerDataSource.swift
//  TVMovies
//
//  Created by Phincon on 15/06/22.
//

import UIKit
import Core
import RxSwift

class ViewControllerDataSource: NSObject {
    weak var vm: TopRateMovieVM!
    weak var vmUpcoming: UpComingMovieVM!
    weak var vmNowPlaying: NowPlayingMovieVM!
    weak var vmPopulerMovie: PopulerMovieVM!
    weak var collectionView: UICollectionView?
    var view: UIViewController?
    var disposeBag = DisposeBag()
    
    init(vm: TopRateMovieVM, vmUpcoming: UpComingMovieVM, vmNowPlaying: NowPlayingMovieVM, vmPopulerMovie: PopulerMovieVM, collectionView: UICollectionView? = nil, view: UIViewController? = nil) {
        
        super.init()
        self.vm = vm
        self.vmUpcoming = vmUpcoming
        self.vmNowPlaying = vmNowPlaying
        self.vmPopulerMovie = vmPopulerMovie
        self.collectionView = collectionView
        self.view = view
        self.showData()
        self.vm.getTopListMovie()
        self.vmUpcoming.getUpcomingListMovie()
        self.vmNowPlaying.getListNowPlayingMovie()
        self.vmPopulerMovie.getListPopulerMovie()
        self.registerCollection()
    }
    
    func registerCollection(){
        collectionView?.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellWithReuseIdentifier: "TopRatedMovieCell")
        collectionView?.register(UINib(nibName: "UpcomingMovieCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMovieCell")
        collectionView?.register(UINib(nibName: "NowPlayingMovieCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieCell")
        collectionView?.register(UINib(nibName: "PopulerMovieCell", bundle: nil), forCellWithReuseIdentifier: "PopulerMovieCell")
    }
    
    func showData(){
        vm.getListTopRateMovieData.drive(onNext: {
            listTopMovie in
            self.collectionView?.reloadData()
            
        }).disposed(by: disposeBag)
        
        vmUpcoming.getListUpcomingMovieData.drive(onNext: {
            [unowned self] listMovie in
            
            self.collectionView?.reloadData()
            
        }).disposed(by: disposeBag)
        
        vmNowPlaying.getListUpcomingMovieData.drive(onNext: {
            [unowned self] nowPlayingMovie in
            
            self.collectionView?.reloadData()
            
        }).disposed(by: disposeBag)
        
        vmPopulerMovie.getListPopulerMovieData.drive(onNext: {
            [unowned self] nowPlayingMovie in
            
            self.collectionView?.reloadData()
            
        }).disposed(by: disposeBag)
    }
}

extension ViewControllerDataSource: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCell", for: indexPath) as? TopRatedMovieCell else { return UICollectionViewCell() }
            
            cell.setContent(vm: vm)
            cell.moveToDetailScreen = {
                [weak self] topRated in
                guard let self = self else { return }
                
                self.moveToDetail(type: .topRateMovie, topRated: topRated , upcoming: nil, nowPlaying: nil, populerMovie: nil )
                
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMovieCell", for: indexPath) as? UpcomingMovieCell else { return UICollectionViewCell() }
            cell.setContent(vm: vmUpcoming)
            
            cell.moveToDetailScreen = {
                [weak self] upcoming in
                guard let self = self else { return }
                
                self.moveToDetail(type: .upcomingMovie, topRated: nil , upcoming: upcoming, nowPlaying: nil, populerMovie: nil)
            }
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCell", for: indexPath) as? NowPlayingMovieCell else { return UICollectionViewCell() }
            
            cell.setContent(vm: vmNowPlaying)
            
            cell.moveToDetailScreen = {
                [weak self] nowPlaying in
                guard let self = self else { return }
                
                self.moveToDetail(type: .nowPlayingMovie, topRated: nil , upcoming: nil, nowPlaying: nowPlaying, populerMovie: nil)
            }
            
            
            return cell
        case 3:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerMovieCell", for: indexPath) as? PopulerMovieCell else { return UICollectionViewCell() }
            cell.setContent(vm: vmPopulerMovie)
            
            cell.moveToDetailScreen = {
                [weak self] populer in
                guard let self = self else { return }
                
                self.moveToDetail(type: .populerMovie, topRated: nil , upcoming: nil, nowPlaying: nil, populerMovie: populer)
            }
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func moveToDetail(type: MovieType, topRated: TopRateMovie? , upcoming: UpcomingMovie?, nowPlaying: NowPlayingMovie?, populerMovie: PopulerMovie?){
        let vc = DetailMovieViewController()
        vc.typeMovie = type
        switch type {
        case .topRateMovie:
            vc.rateMovie = topRated
        case .upcomingMovie:
            vc.upcomingMovie = upcoming
        case .nowPlayingMovie:
            vc.nowPlayingMovie = nowPlaying
        case .populerMovie:
            vc.populerMovie = populerMovie
        }
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 3.5)
    }
}
