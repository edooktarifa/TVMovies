//
//  PopulerMovieInjection.swift
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

class PopulerMovieInjection {
    static let shared = PopulerMovieInjection()
    
    let container = Container(){
        container in
        
        container.register(Network.self) {
            _ in
            Network<PopulerMovieModel>.init()
        }
        
        container.register(CoreDataManager.self) {_ in
            CoreDataManager()
        }
        
        container.register(PopulerMovieRepo.self){
            resolver in
            PopulerMovieImpl(apiServices: resolver.resolve(Network<PopulerMovieModel>.self)!, localData: resolver.resolve(CoreDataManager.self)!)
            
        }
        
        container.register(PopulerMovieUserCase.self){
            resolver in
            PopulerMovieUserCase(listMovieRepo: resolver.resolve(PopulerMovieRepo.self)!)
        }
        
        container.register(PopulerMovieVM.self){
            resolver in
            PopulerMovieVM(listMovieUseCase: resolver.resolve(PopulerMovieUserCase.self)!)
        }
    }
}
