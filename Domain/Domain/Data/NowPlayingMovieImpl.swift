//
//  NowPlayingMovieImpl.swift
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

public final class NowPlayingMovieImpl: NowPlayingMovieRepo {

    var apiServices: Network<NowPlayingMovieModel>
    let param: Parameters = ["language":"en-US", "page":"10"]
    
    private var listFromCoreData = BehaviorRelay<NowPlayingMovie?>(value: nil)
    private var getListDataFromCoreData = BehaviorRelay<[NowPlayingMovie]>(value: [])
    
    var localData : CoreDataManager
    
    public init(apiServices: Network<NowPlayingMovieModel>, localData: CoreDataManager){
        self.apiServices = apiServices
        self.localData = localData
    }
    
    public func getListNowPlayingMovie() -> Observable<NowPlayingMovieModel> {
        apiServices.request(url: "movie/now_playing", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
    
    public func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<NowPlayingMovie?> {
        listFromCoreData.accept(localData.insertNowPlayingMovie(insertList: inserList))
        return listFromCoreData.asObservable()
    }
    
    public func getListMovieFromCoreData() -> Observable<[NowPlayingMovie]> {
        getListDataFromCoreData.accept(localData.fetchAllPlayingMovie() ?? [])
        return getListDataFromCoreData.asObservable()
    }
}
