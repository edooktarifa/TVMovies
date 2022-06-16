//
//  NowPlayingMovie.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import NetworkServices
import RxCocoa
import RxSwift
import UIKit
import Core
import Domain
import Common

class NowPlayingMovieVM {
    var disposeBag = DisposeBag()
    
    var listNowPlayingMovieUseCase: NowPlayingUseCase
    let error = BehaviorRelay<ErrorMessage?>(value: nil)
    
    private let getList = BehaviorRelay<[NowPlayingMovie]>(value: [])
    
    var getListUpcomingMovieData: Driver<[NowPlayingMovie]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfTopRatedMovie: Int {
        return getList.value.count
    }
    
    func modelForIndex(at index: Int) -> NowPlayingMovie? {
        guard index < getList.value.count else {
            return nil
        }
        return getList.value[index]
    }
    
    
    init(listMovieUseCase: NowPlayingUseCase) {
        self.listNowPlayingMovieUseCase = listMovieUseCase
    }
    
    func getListNowPlayingMovie(){
        listNowPlayingMovieUseCase.getListNowPlayingMovie().observeOn(MainScheduler.instance).subscribe(onNext: {
            listMovie in
            
            for data in listMovie.results ?? [] {
                self.insertListNowPlayingMovieToDB(list: data)
            }
            
            self.getListNewPlayingMovieFromCoreData()
            
        }, onError: {
            
            error in
            
            switch error {
            case ApiError.conflict:
                self.error.accept(.conflict)
            case ApiError.forbidden:
                self.error.accept(.forbidden)
            case ApiError.notFound:
                self.error.accept(.notFound)
            case ApiError.internalServerError:
                self.error.accept(.internalServerError)
            default:
                self.error.accept(.unknownError)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func insertListNowPlayingMovieToDB(list: TopRatedMovieResult){
        listNowPlayingMovieUseCase.insertListMovieToCoreData(insertList: list).observeOn(MainScheduler.instance).subscribe(onNext: {
            insertMovie in
            
            guard let insertMovie = insertMovie else { return }
            
            self.getList.add(element: insertMovie)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func getListNewPlayingMovieFromCoreData(){
        
        listNowPlayingMovieUseCase.getListMovieFromCoreData().observeOn(MainScheduler.instance).subscribe(onNext: {
            
            getListMovie in
            if getListMovie != [] {
                self.getList.accept(getListMovie)
                
            } else {
                self.getListNowPlayingMovie()
            }
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
}
