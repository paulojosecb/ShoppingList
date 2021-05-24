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
            let cdItemOnList: CDItemOnList? = self.coreDataStack.fetch(by: uuid)
            
            guard cdItemOnList != nil else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            fulfill(ItemOnList.make(from: cdItemOnList!) as! T)
        }
    }
    
    func fetch<T: Fetchable>(uuids: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            let cdItemOnList = CDItemOnList(context: self.coreDataStack.mainContext)
            
            let _ = ItemOnList.make(from: item as! ItemOnList, cdItemOnList: cdItemOnList)
            
            do {
                try self.coreDataStack.mainContext.save()
                fulfill(item)
            } catch _ {
                reject(ICRUDRepositoryError.errorOnOperaration)
            }
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    
}
