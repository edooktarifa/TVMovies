//
//  NowPlayingMovieInjection.swift
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

class NowPlayingMovieInjection {
    static let shared = NowPlayingMovieInjection()
    
    let container = Container(){
        container in
        
        container.register(Network.self) {
            _ in
            Network<NowPlayingMovieModel>.init()
        }
        
        container.register(CoreDataManager.self) {_ in
            CoreDataManager()
        }
        
        container.register(NowPlayingMovieRepo.self){
            resolver in
            NowPlayingMovieImpl(apiServices: resolver.resolve(Network<NowPlayingMovieModel>.self)!, localData: resolver.resolve(CoreDataManager.self)!)
        }
        
        container.register(NowPlayingUseCase.self){
            resolver in
            NowPlayingUseCase(listMovieRepo: resolver.resolve(NowPlayingMovieRepo.self)!)
        }
        
        container.register(NowPlayingMovieVM.self){
            resolver in
            NowPlayingMovieVM(listMovieUseCase: resolver.resolve(NowPlayingUseCase.self)!)
        }
    }
}
