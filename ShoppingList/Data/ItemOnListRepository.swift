//
//  ItemOnListRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 21/05/21.
//

import Foundation
import Promises
import CoreData

class ItemOnListRepository: ICRUDRepository {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    func fetch<T: Fetchable>(uuids: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    
}
