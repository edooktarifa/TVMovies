//
//  PopulerMovieImpl.swift
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

public final class PopulerMovieImpl: PopulerMovieRepo {

    var apiServices: Network<PopulerMovieModel>
    let param: Parameters = ["language":"en-US", "page":"10"]
    
    private var listFromCoreData = BehaviorRelay<PopulerMovie?>(value: nil)
    private var getListDataFromCoreData = BehaviorRelay<[PopulerMovie]>(value: [])
    var localData : CoreDataManager
    
    public init(apiServices: Network<PopulerMovieModel>, localData: CoreDataManager){
        self.apiServices = apiServices
        self.localData = localData
    }
    
    public func getListPopulerMovie() -> Observable<PopulerMovieModel> {
        apiServices.request(url: "movie/popular", method: .get, parameters: param, encoding: URLEncoding.default, headers: [:])
    }
    
    public func insertListMovieToCoreData(inserList: TopRatedMovieResult) -> Observable<PopulerMovie?>{
        
        listFromCoreData.accept(localData.insertPopulerMovie(insertList: inserList))
        return listFromCoreData.asObservable()
    }
    
    public func getListMovieFromCoreData() -> Observable<[PopulerMovie]> {
        getListDataFromCoreData.accept(localData.fetchAllPopulerMovie() ?? [])
        return getListDataFromCoreData.asObservable()
    }
}
