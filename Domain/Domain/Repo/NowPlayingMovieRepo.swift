//
//  NowPlayingMovieRepo.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public protocol NowPlayingMovieRepo {
    func getListNowPlayingMovie() -> Observable<NowPlayingMovieModel>
    func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<NowPlayingMovie?>
    func getListMovieFromCoreData() -> Observable<[NowPlayingMovie]>
}
