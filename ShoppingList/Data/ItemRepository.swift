//
//  ItemRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation
import Promises
import CoreData

class ItemRepository: IItemRepository {

    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    func fetchBy<T>(name: String) -> Promise<[T]> where T : Fetchable {
        let fetchRequest: NSFetchRequest<CDItem> = CDItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[c] %@", name)
    
        return Promise { fullfill, reject in
            
            let cdItems = self.coreDataStack.fetchItemsByNames(query: name)
            
            let items = cdItems.map { (cdItem) in
                return Item.make(from: cdItem)
            }
            
            fullfill(items as? [T] ?? [])
        }
    }
        
    func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in

            
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T: Fetchable {
        return Promise { fulfill, reject in

        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
}
