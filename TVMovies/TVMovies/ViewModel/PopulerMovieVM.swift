//
//  PopulerMovieVM.swift
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
import CoreData

class PopulerMovieVM {
    var disposeBag = DisposeBag()
    
    var listPopulerMovieUseCase: PopulerMovieUserCase
    let error = BehaviorRelay<ErrorMessage?>(value: nil)
    
    
    private let getList = BehaviorRelay<[PopulerMovie]>(value: [])
    
    var getListPopulerMovieData: Driver<[PopulerMovie]>{
        return getList.asDriver()
    }
    
    var errorMessage: Driver<ErrorMessage?>{
        return error.asDriver()
    }
    
    var numberOfTopPopulerMovie: Int {
        return getList.value.count
    }
    
    func modelForIndex(at index: Int) -> PopulerMovie? {
        guard index < getList.value.count else {
            return nil
        }
        return getList.value[index]
    }
    
    func searchIndex() -> [PopulerMovie] {
        return getList.value
    }
    
    
    init(listMovieUseCase: PopulerMovieUserCase) {
        self.listPopulerMovieUseCase = listMovieUseCase
    }
    
    func getListPopulerMovie(){
        listPopulerMovieUseCase.getListPopulerMovie().observeOn(MainScheduler.instance).subscribe(onNext: {
            listMovie in
            
            for data in listMovie.results ?? [] {
                self.insertListPopularMovieToDB(list: data)
            }
            
            self.getListNewPopularMovieFromCoreData()
          
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
    
    func insertListPopularMovieToDB(list: TopRatedMovieResult){
        listPopulerMovieUseCase.insertListMovieToCoreData(insertList: list).observeOn(MainScheduler.instance).subscribe(onNext: {
            insertMovie in
            
            guard let insertMovie = insertMovie else { return }
            self.getList.add(element: insertMovie)
            
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
    
    func getListNewPopularMovieFromCoreData(){
        
        listPopulerMovieUseCase.getListMovieFromCoreData().observeOn(MainScheduler.instance).subscribe(onNext: {
            
            getListMovie in
            if getListMovie != [] {
                self.getList.accept(getListMovie)
                
            } else {
                self.getListPopulerMovie()
            }
        }, onError: {
            error in
        }).disposed(by: disposeBag)
    }
}
