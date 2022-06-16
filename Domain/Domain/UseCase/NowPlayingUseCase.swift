//
//  NowPlayingUseCase.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public class NowPlayingUseCase {
    let listMovieRepo: NowPlayingMovieRepo
    
    public init(listMovieRepo: NowPlayingMovieRepo){
        self.listMovieRepo = listMovieRepo
    }
    
    public func getListNowPlayingMovie() -> Observable<NowPlayingMovieModel>{
        listMovieRepo.getListNowPlayingMovie()
    }
    
    public func insertListMovieToCoreData(insertList: TopRatedMovieResult) -> Observable<NowPlayingMovie?>{
        listMovieRepo.insertListMovieToCoreData(inserList: insertList)
    }
    
    public func getListMovieFromCoreData() -> Observable<[NowPlayingMovie]>{
        listMovieRepo.getListMovieFromCoreData()
    }
}
