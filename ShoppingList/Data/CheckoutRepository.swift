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
                        
            guard let cdCheckout: CDCheckout = self.coreDataStack.fetch(by: uuid),
                  let items = cdCheckout.items?.array as? [CDItemOnList] else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            
            let itemsOnList = items.map { ItemOnList.make(from: $0)}
                        
            let checkOut = Checkout(listUUID: cdCheckout.list!.uuid!,
                                    items: itemsOnList,
                                    total: cdCheckout.total,
                                    date: cdCheckout.date!,
                                    location: Location.make(from: cdCheckout.location))
            
            fulfill(checkOut as! T)
        }
    }
    
    func fetch<T: Fetchable>(uuids: String) -> Promise<[T]> {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func fetch<T>() -> Promise<[T]> where T : Fetchable {
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
            
            guard let list: CDList = self.coreDataStack.fetch(by: checkout.uuid) else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            let cdItemsOnList: [CDItemOnList]? = self.coreDataStack.fetchItemsOnList(by: checkout.items.map {$0.uuid} )
            


            
            do {
                let cdCheckOut = CDCheckout(context: self.managedObjectContext)
                cdCheckOut.date = checkout.date
                cdCheckOut.items = NSOrderedSet(array: cdItemsOnList ?? [])
                cdCheckOut.list = list
                cdCheckOut.total = checkout.total
                cdCheckOut.uuid = checkout.uuid
                
                if (checkout.location != nil) {
                    let cdLocation = CDLocation(context: self.managedObjectContext)
                    cdLocation.latitude = checkout.location!.latitude
                    cdLocation.longitude = checkout.location!.longitude
                    
                    cdCheckOut.location = cdLocation
                }

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
            
            guard let cdList: CDList = self.coreDataStack.fetch(by: checkout.listUUID) else {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            let itemsOnList = self.coreDataStack.fetchItemsOnList(by: checkout.items.map { $0.uuid })

            
            cdCheckOut.date = checkout.date
            cdCheckOut.items = NSOrderedSet(array: itemsOnList ?? [])
            cdCheckOut.list = cdList
            cdCheckOut.total = checkout.total
            cdCheckOut.uuid = checkout.uuid
            
            if checkout.location != nil {
                cdCheckOut.location = CDLocation(context: self.managedObjectContext)
                cdCheckOut.location?.latitude = checkout.location!.latitude
                cdCheckOut.location?.longitude = checkout.location!.longitude
            }
                        
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

