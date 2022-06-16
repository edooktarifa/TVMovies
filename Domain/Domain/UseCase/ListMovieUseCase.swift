//
//  ListMovieUseCase.swift
//  Domain
//
//  Created by Phincon on 11/06/22.
//

import Foundation
import RxSwift
import Core

public class ListMovieUseCase {
    let listMovieRepo: ListMovieRepo
    
    public init(listMovieRepo: ListMovieRepo){
        self.listMovieRepo = listMovieRepo
    }
    
    public func getListMovie() -> Observable<TopRatedMovieModel>{
        listMovieRepo.getListMovie()
    }
    
    public func insertListMovieToCoreData(insertList: TopRatedMovieResult) -> Observable<TopRateMovie?>{
        listMovieRepo.insertListMovieToCoreData(inserList: insertList)
    }
    
    public func getListMovieFromCoreData() -> Observable<[TopRateMovie]>{
        listMovieRepo.getListMovieFromCoreData()
    }
}
