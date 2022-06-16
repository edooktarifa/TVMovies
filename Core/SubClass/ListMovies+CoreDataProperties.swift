//
//  ListMovies+CoreDataProperties.swift
//  
//
//  Created by Phincon on 11/06/22.
//
//

import Foundation
import CoreData


extension ListMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListMovies> {
        return NSFetchRequest<ListMovies>(entityName: "ListMovies")
    }


}
