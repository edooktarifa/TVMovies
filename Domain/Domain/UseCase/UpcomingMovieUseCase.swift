//
//  UpcomingMovieUseCase.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public class UpcomingMovieUseCase {
    let listMovieRepo: UpcomingMovieRepo
    
    public init(listMovieRepo: UpcomingMovieRepo){
        self.listMovieRepo = listMovieRepo
    }
    
    public func getListUpcomingMovie() -> Observable<UpcomingMovieModel>{
        listMovieRepo.getListUpcomingMovie()
    }
    
    public func insertListMovieToCoreData(insertList: TopRatedMovieResult) -> Observable<UpcomingMovie?>{
        listMovieRepo.insertListMovieToCoreData(inserList: insertList)
    }
    
    public func getListMovieFromCoreData() -> Observable<[UpcomingMovie]>{
        listMovieRepo.getListMovieFromCoreData()
    }
}
