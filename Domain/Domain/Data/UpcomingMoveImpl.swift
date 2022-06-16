//
//  UpcomingMoveImpl.swift
//  Domain
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa
import NetworkServices
import Core

public final class UpcomingMovieImpl: UpcomingMovieRepo {

    var apiServices: Network<UpcomingMovieModel>
    let param: Parameters = ["language":"en-US", "page":"10"]
    
    private var listFromCoreData = BehaviorRelay<UpcomingMovie?>(value: nil)
    private var getListDataFromCoreData = BehaviorRelay<[UpcomingMovie]>(value: [])
    
    var localData : CoreDataManager
    
    public init(apiServices: Network<UpcomingMovieModel>, localData: CoreDataManager){
        self.apiServices = apiServices
        self.localData = localData
    }
    
    public func getListUpcomingMovie() -> Observable<UpcomingMovieModel> {
        apiServices.request(url: "movie/upcoming", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
    
    public func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<UpcomingMovie?> {
        listFromCoreData.accept(localData.insertUpcomingMovie(insertList: inserList))
        return listFromCoreData.asObservable()
    }
    
    public func getListMovieFromCoreData() -> Observable<[UpcomingMovie]> {
        getListDataFromCoreData.accept(localData.fetchAllUpcomingMovie() ?? [])
        return getListDataFromCoreData.asObservable()
    }
}
