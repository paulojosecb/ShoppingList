//
//  CheckoutRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises
import CoreData

class CheckoutRepository: ICRUDRepository {
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack

    // MARK: - Initializers
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
      self.managedObjectContext = managedObjectContext
      self.coreDataStack = coreDataStack
    }
    
    var checkouts: [Checkout] = []
    
    func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
            let cdCheckout: CDCheckout? = self.coreDataStack.fetch(by: uuid)
            
            let cdItemsOnList = self.coreDataStack.fetchItemsOnList(by: (cdCheckout?.items as? [String]) ?? [])
            
            let itemsOnList = cdItemsOnList?.map { ItemOnList.make(from: $0)} ?? []
                        
            let checkOut = Checkout(listUUID: cdCheckout!.listUUID!,
                                    items: itemsOnList,
                                    total: cdCheckout!.total,
                                    date: cdCheckout!.date!,
                                    location: cdCheckout!.location as? Location)
            
            fulfill(checkOut as! T)
        }
    }
    
    func fetch<T: Fetchable>(uuids: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            
            guard let checkout = item as? Checkout else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            do {
                let cdCheckOut = CDCheckout(context: self.managedObjectContext)
                cdCheckOut.date = checkout.date
                cdCheckOut.items = checkout.items.map { $0.uuid } as NSObject
                cdCheckOut.listUUID = checkout.listUUID
                cdCheckOut.location = checkout.location
                cdCheckOut.total = checkout.total
                cdCheckOut.uuid = checkout.uuid

                try self.managedObjectContext.save()
                
                fulfill(checkout as! T)
            } catch _ {
                reject(ICRUDRepositoryError.errorOnOperaration)
            }
            
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T: Fetchable {
        return Promise { fulfill, reject in
            guard let checkout = item as? Checkout else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            guard let cdCheckOut: CDCheckout = self.coreDataStack.fetch(by: item.uuid) else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            cdCheckOut.date = checkout.date
            cdCheckOut.items = checkout.items.map { $0.uuid } as NSObject
            cdCheckOut.listUUID = checkout.listUUID
            cdCheckOut.location = checkout.location
            cdCheckOut.total = checkout.total
            cdCheckOut.uuid = checkout.uuid
                        
            fulfill(checkout as! T)
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fulfill, reject in
            
            guard let cdCheckout: CDCheckout = self.coreDataStack.fetch(by: item.uuid) else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            self.coreDataStack.mainContext.delete(cdCheckout)
            self.coreDataStack.saveContext()
            
            fulfill(true)
        }
    }
    
}

