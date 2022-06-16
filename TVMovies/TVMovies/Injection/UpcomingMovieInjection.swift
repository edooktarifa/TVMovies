//
//  UpcomingMovieInjection.swift
//  TVMovies
//
//  Created by Phincon on 13/06/22.
//

import Foundation
import UIKit
import NetworkServices
import Core
import Domain
import Swinject

class UpcomingMovieInjection {
    static let shared = UpcomingMovieInjection()
    
    let container = Container(){
        container in
        
        container.register(Network.self) {
            _ in
            Network<UpcomingMovieModel>.init()
        }
        
        container.register(CoreDataManager.self) {_ in
            CoreDataManager()
        }
        
        container.register(UpcomingMovieRepo.self){
            resolver in
            UpcomingMovieImpl(apiServices: resolver.resolve(Network<UpcomingMovieModel>.self)!, localData: resolver.resolve(CoreDataManager.self)!)
        }
        
        container.register(UpcomingMovieUseCase.self){
            resolver in
            UpcomingMovieUseCase(listMovieRepo: resolver.resolve(UpcomingMovieRepo.self)!)
        }
        
        container.register(UpComingMovieVM.self){
            resolver in
            UpComingMovieVM(listMovieUseCase: resolver.resolve(UpcomingMovieUseCase.self)!)
        }
        
        
    }
}
