//
//  MockItemOnListRepository.swift
//  ShoppingListTests
//
//  Created by Paulo José on 24/05/21.
//

import Foundation
import Promises
@testable import ShoppingList

class MockItemOnListRepository: IItemRepository {

    var items: [ItemOnList] = []
    
    func fetchBy<T>(name: String) -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            
        }
    }
    
    
    func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
        return Promise { fullfill, reject in
            fatalError()
        }
    }
    
    func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
        return Promise { fullfill, reject in
            guard let items = (self.items.first { $0.uuid == uuid }) else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            fullfill(items as! T)
        }
    }
    
    func fetch<T>() -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func create<T: Fetchable>(_ item: T) -> Promise<T> {
        return Promise { fullfill, reject in
            
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fullfill, reject in
            var storeItem = self.items.first { $0.uuid == item.uuid }
            
            if (storeItem != nil) {
                storeItem = item as! ItemOnList
                fullfill(item)
            } else {
                reject(ICRUDRepositoryError.notFound)
            }
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fullfill, reject in

        }
    }

}
