//
//  ListMovieInjection.swift
//  TVMovies
//
//  Created by Phincon on 11/06/22.
//

import Foundation
import UIKit
import NetworkServices
import Core
import Domain
import Swinject

class ListMovieInjection {
    static let shared = ListMovieInjection()
    
    let container = Container(){
        container in
        
        container.register(Network.self) {
            _ in
            Network<TopRatedMovieModel>.init()
        }
        
        container.register(CoreDataManager.self) {_ in
            CoreDataManager()
        }
        
        container.register(ListMovieRepo.self){
            resolver in
            ListMovieImpl(apiServices: resolver.resolve(Network<TopRatedMovieModel>.self)!, localData: resolver.resolve(CoreDataManager.self)!)
        }
        
        container.register(ListMovieUseCase.self){
            resolver in
            ListMovieUseCase(listMovieRepo: resolver.resolve(ListMovieRepo.self)!)
        }
        
        container.register(TopRateMovieVM.self){
            resolver in
            TopRateMovieVM(listMovieUseCase: resolver.resolve(ListMovieUseCase.self)!)
        }
        
        
    }
}
