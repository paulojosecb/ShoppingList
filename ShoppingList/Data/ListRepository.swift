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
            
            let cdList: CDList? = self.coreDataStack.fetch(by: uuid)
            let cdCart: CDCart? = self.coreDataStack.fetch(by: cdList!.uuid!)
            
            let cdItemsOnList = self.coreDataStack.fetchItemsOnList(by: (cdList?.items as? [String]) ?? [])
            let cartItemsOnList = self.coreDataStack.fetchItemsOnList(by: (cdCart?.items as? [String]) ?? [])
            
            let itemsOnList = cdItemsOnList?.map { ItemOnList.make(from: $0)} ?? []
            
            let cart = Cart.make(from: cdCart!, and: cartItemsOnList ?? [])
            
            let list = List(uuid: cdList!.uuid!,
                            name: cdList!.name!,
                            items: itemsOnList,
                            cart: cart,
                            isTempl: cdList!.isTemplate)
            
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
            fatalError()
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
                cdList.items = list.getItemsFromList().map { $0.uuid } as NSObject
                cdList.cartUUID = list.cart.uuid
                cdList.isTemplate = list.isTemplate
                
                _ = list.getItemsFromList().map { itemOnList -> CDItemOnList in
                    let cdItemOnList = CDItemOnList(context: self.managedObjectContext)
                    return ItemOnList.make(from: itemOnList, cdItemOnList: cdItemOnList)
                }
 
                let cdCart = CDCart(context: self.managedObjectContext)
                cdCart.uuid = list.cart.uuid
                cdCart.listUUID = list.uuid
                cdCart.items = list.getItemsFromCart().map { $0.uuid } as NSObject
            
                _ = list.getItemsFromCart().map { itemOnList -> CDItemOnList in
                    let cdItemOnList = CDItemOnList(context: self.managedObjectContext)
                    return ItemOnList.make(from: itemOnList, cdItemOnList: cdItemOnList)
                }
                
                try self.managedObjectContext.save()
                
                fulfill(list as! T)
            } catch let error {
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
