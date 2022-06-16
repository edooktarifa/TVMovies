//
//  ListMovieRepo.swift
//  Domain
//
//  Created by Phincon on 11/06/22.
//

import Foundation
import RxSwift
import Core

public protocol ListMovieRepo {
    func getListMovie() -> Observable<TopRatedMovieModel>
    func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<TopRateMovie?>
    func getListMovieFromCoreData() -> Observable<[TopRateMovie]>
}
