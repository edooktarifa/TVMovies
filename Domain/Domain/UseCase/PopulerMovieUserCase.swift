//
//  PopulerMovieUserCase.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import RxSwift
import Core

public class PopulerMovieUserCase {
    let listMovieRepo: PopulerMovieRepo
    
    public init(listMovieRepo: PopulerMovieRepo){
        self.listMovieRepo = listMovieRepo
    }
    
    public func getListPopulerMovie() -> Observable<PopulerMovieModel>{
        listMovieRepo.getListPopulerMovie()
    }
    
    public func insertListMovieToCoreData(insertList: TopRatedMovieResult) -> Observable<PopulerMovie?>{
        listMovieRepo.insertListMovieToCoreData(inserList: insertList)
    }
    
    public func getListMovieFromCoreData() -> Observable<[PopulerMovie]>{
        listMovieRepo.getListMovieFromCoreData()
    }
}
