//
//  CoreDataManager.swift
//  Core
//
//  Created by Phincon on 14/06/22.
//

import Foundation
import CoreData
import UIKit

public class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    public init() {}
    
    let identifier: String  = "asd.Core"
    let model: String       = "CoreMovie"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.model, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            
            if let err = error{
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // MARK: -insert data to DB
    public func insertTopRateMovies(insertList withData: TopRatedMovieResult) -> TopRateMovie? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "TopRateMovie", in: managedContext)!
        
        let topRatedMovie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        topRatedMovie.setValue(withData.backdropPath, forKey: "topRateImage")
        topRatedMovie.setValue(withData.originalTitle, forKey: "topRatedTitle")
        topRatedMovie.setValue(withData.overview, forKey: "overview")
        
        do {
            try managedContext.save()
            return topRatedMovie as? TopRateMovie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func fetchAllTopRateMovies() -> [TopRateMovie]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TopRateMovie")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [TopRateMovie]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func insertUpcomingMovie(insertList withData: TopRatedMovieResult) -> UpcomingMovie? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "UpcomingMovie", in: managedContext)!
        
        let upcomingMovie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        upcomingMovie.setValue(withData.backdropPath, forKey: "upcomingMovieImage")
        upcomingMovie.setValue(withData.originalTitle, forKey: "upcomingMovieTitle")
        upcomingMovie.setValue(withData.overview, forKey: "overview")
        do {
            try managedContext.save()
            return upcomingMovie as? UpcomingMovie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    public func fetchAllUpcomingMovie() -> [UpcomingMovie]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UpcomingMovie")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [UpcomingMovie]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func insertPopulerMovie(insertList withData: TopRatedMovieResult) -> PopulerMovie? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "PopulerMovie", in: managedContext)!
        
        let populerMovie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        populerMovie.setValue(withData.backdropPath, forKey: "populerMovieImage")
        populerMovie.setValue(withData.originalTitle, forKey: "populerMovieTitle")
        populerMovie.setValue(withData.overview, forKey: "overview")
        
        do {
            try managedContext.save()
            return populerMovie as? PopulerMovie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    public func fetchAllPopulerMovie() -> [PopulerMovie]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PopulerMovie")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [PopulerMovie]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    public func insertNowPlayingMovie(insertList withData: TopRatedMovieResult) -> NowPlayingMovie? {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "NowPlayingMovie", in: managedContext)!
        
        let nowPlayingMovie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        
        nowPlayingMovie.setValue(withData.backdropPath, forKey: "nowPlayingMovieImage")
        nowPlayingMovie.setValue(withData.originalTitle, forKey: "nowPlayingMovieTitle")
        nowPlayingMovie.setValue(withData.overview, forKey: "overview")
        do {
            try managedContext.save()
            return nowPlayingMovie as? NowPlayingMovie
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
    public func fetchAllPlayingMovie() -> [NowPlayingMovie]?{
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NowPlayingMovie")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            return people as? [NowPlayingMovie]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
