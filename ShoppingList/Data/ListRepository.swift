//
//  MainDataRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 03/05/21.
//

import Foundation
import Promises
import CoreData

class ListRepository: ICRUDRepository {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    var list: [List] = []
    
    func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
            guard let cdList: CDList = self.coreDataStack.fetch(by: uuid) else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
                                
            let list = List.make(from: cdList)
            
            fulfill(list as! T)
        }
    }
    
    func fetch<T: Fetchable>(uuids: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func fetch<T>() -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
            guard let list = item as? List else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            do {
                let cdList = CDList(context: self.managedObjectContext)
                cdList.name = list.name
                cdList.uuid = list.uuid
                cdList.isTemplate = list.isTemplate
                cdList.items = []
                cdList.cart = []
                
                try self.managedObjectContext.save()
                
                fulfill(list as! T)
            } catch _ {
                reject(ICRUDRepositoryError.errorOnOperaration)
            }
            
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T: Fetchable {
        return Promise { fulfill, reject in
            guard var itemToUpdate = self.list.filter({ $0.uuid == item.uuid }).first else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            itemToUpdate = item as! List
            
            fulfill(itemToUpdate as! T)
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fulfill, reject in
            let cdL: CDList? = self.coreDataStack.fetch(by: item.uuid)
            
            guard let cdList = cdL else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            self.coreDataStack.mainContext.delete(cdList)
            self.coreDataStack.saveContext()
            
            fulfill(true)
        }
    }
    
}
