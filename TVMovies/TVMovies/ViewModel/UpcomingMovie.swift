//
//  UpcomingMovie.swift
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

class UpComingMovieVM {
    var disposeBag = DisposeBag()
    
    var listUpcomingMovieUseCase: UpcomingMovieUseCase
    let error = BehaviorRelay<ErrorMessage?>(value: nil)
    
    init(listMovieUseCase: UpcomingMovieUseCase) {
        self.listUpcomingMovieUseCase = listMovieUseCase
    }
    
    private let getList = BehaviorRelay<[UpcomingMovie]>(value: [])
    
    var getListUpcomingMovieData: Driver<[UpcomingMovie]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfTopRatedMovie: Int {
        return getList.value.count
    }
    
    func modelForIndex(at index: Int) -> UpcomingMovie? {
        guard index < getList.value.count else {
            return nil
        }
        return getList.value[index]
    }
    
    func getUpcomingListMovie(){
        listUpcomingMovieUseCase.getListUpcomingMovie().observeOn(MainScheduler.instance).subscribe(onNext: {
            listMovie in
            
            for data in listMovie.results ?? [] {
                self.insertListUpcomingMovieToDB(list: data)
            }
            
            self.getListUpcomingMovieFromCoreData()
            
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
                self.getListUpcomingMovieFromCoreData()
                self.error.accept(.unknownError)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func insertListUpcomingMovieToDB(list: TopRatedMovieResult){
        listUpcomingMovieUseCase.insertListMovieToCoreData(insertList: list).observeOn(MainScheduler.instance).subscribe(onNext: {
            insertMovie in
            
            guard let insertMovie = insertMovie else { return }
            
            self.getList.add(element: insertMovie)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func getListUpcomingMovieFromCoreData(){
        
        listUpcomingMovieUseCase.getListMovieFromCoreData().observeOn(MainScheduler.instance).subscribe(onNext: {
            
            getListMovie in
            if getListMovie != [] {
                self.getList.accept(getListMovie)
                
            } else {
                self.getUpcomingListMovie()
            }
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
}
