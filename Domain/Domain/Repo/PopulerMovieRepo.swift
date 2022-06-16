//
//  PopulerMovieRepo.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public protocol PopulerMovieRepo {
    func getListPopulerMovie() -> Observable<PopulerMovieModel>
    func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<PopulerMovie?>
    func getListMovieFromCoreData() -> Observable<[PopulerMovie]>
}
