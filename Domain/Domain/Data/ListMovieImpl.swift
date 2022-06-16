//
//  ListMovieImpl.swift
//  Domain
//
//  Created by Phincon on 11/06/22.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import NetworkServices
import Core

public final class ListMovieImpl: ListMovieRepo {
   
    var apiServices: Network<TopRatedMovieModel>
    private var listFromCoreData = BehaviorRelay<TopRateMovie?>(value: nil)
    private var getListDataFromCoreData = BehaviorRelay<[TopRateMovie]>(value: [])
    
    let param: Parameters = ["language":"en-US", "page":"10"]
    
    var localData : CoreDataManager
    
    public init(apiServices: Network<TopRatedMovieModel>, localData: CoreDataManager){
        self.apiServices = apiServices
        self.localData = localData
    }
    
    public func getListMovie() -> Observable<TopRatedMovieModel>{
        apiServices.request(url: "movie/top_rated", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
    
    public func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<TopRateMovie?> {
        listFromCoreData.accept(localData.insertTopRateMovies(insertList: inserList))
        return listFromCoreData.asObservable()
    }
    
    public func getListMovieFromCoreData() -> Observable<[TopRateMovie]> {
        getListDataFromCoreData.accept(localData.fetchAllTopRateMovies() ?? [])
        return getListDataFromCoreData.asObservable()
    }
}
