//
//  UpcomingMovieRepo.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public protocol UpcomingMovieRepo {
    func getListUpcomingMovie() -> Observable<UpcomingMovieModel>
    func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<UpcomingMovie?>
    func getListMovieFromCoreData() -> Observable<[UpcomingMovie]>
}
