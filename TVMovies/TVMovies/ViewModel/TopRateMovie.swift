//
//  TopRatedMovie.swift
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

class TopRateMovieVM {
    var disposeBag = DisposeBag()
    
    var listMovieUseCase: ListMovieUseCase
    let error = BehaviorRelay<ErrorMessage?>(value: nil)
    private let getList = BehaviorRelay<[TopRateMovie]>(value: [])
    
    var getListTopRateMovieData: Driver<[TopRateMovie]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfTopRatedMovie: Int {
        return getList.value.count
    }
    
    
    init(listMovieUseCase: ListMovieUseCase) {
        self.listMovieUseCase = listMovieUseCase
    }
    
    func modelForIndex(at index: Int) -> TopRateMovie? {
        guard index < getList.value.count else {
            return nil
        }
        
        return getList.value[index]
    }
    
    func getTopListMovie(){
        listMovieUseCase.getListMovie().observeOn(MainScheduler.instance).subscribe(onNext: {
            listMovie in
            
            for data in listMovie.results ?? [] {
                self.insertListTopRateMovieToDB(list: data)
            }
            
            self.getListTopMovieFromCoreData()
            
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
    
    func insertListTopRateMovieToDB(list: TopRatedMovieResult){
        listMovieUseCase.insertListMovieToCoreData(insertList: list).observeOn(MainScheduler.instance).subscribe(onNext: {
            insertMovie in
            
            guard let insertMovie = insertMovie else { return }
            self.getList.add(element: insertMovie)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func getListTopMovieFromCoreData(){
        
        listMovieUseCase.getListMovieFromCoreData().observeOn(MainScheduler.instance).subscribe(onNext: {
            
            getListMovie in
            if getListMovie != [] {
                self.getList.accept(getListMovie)
                
            } else {
                self.getTopListMovie()
            }
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
}
