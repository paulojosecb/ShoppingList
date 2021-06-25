//
//  MockCheckoutRepository.swift
//  ShoppingListTests
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises
@testable import ShoppingList

class MockCheckoutRepository: ICRUDRepository {
    
    var errorMock = false
    var checkouts: [Checkout] = [
        Checkout(listUUID: "myList",
                 items: [ItemOnList(item: Item(name: "item1", isBulk: true, prices: [], uuid: "item1"),
                                    on: "myList",
                                    quantity: 1,
                                    unitPrice: nil,
                                    uuid: nil)],
                 total: 3,
                 date: Date(),
                 location: nil),
        Checkout(listUUID: "myList2",
                 items: [ItemOnList(item: Item(name: "item1", isBulk: true, prices: [], uuid: "item1"),
                                    on: "myList",
                                    quantity: 1,
                                    unitPrice: nil,
                                    uuid: nil)],
                 total: 3,
                 date: Date(),
                 location: nil),
        Checkout(listUUID: "myList3",
                 items: [ItemOnList(item: Item(name: "item1", isBulk: true, prices: [], uuid: "item1"),
                                    on: "myList",
                                    quantity: 1,
                                    unitPrice: nil,
                                    uuid: nil)],
                 total: 3,
                 date: Date(),
                 location: nil),
    ]
    
    func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
        return Promise { fullfill, reject in
            let checkout = self.checkouts.filter { $0.uuid == uuid}
            fullfill(checkout.first as! T)
        }
    }
    
    func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    func fetch<T>() -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            fulfill(self.checkouts as! [T])
        }
    }
    
    func create<T: Fetchable>(_ item: T) -> Promise<T> {
        return Promise { fullfill, reject in
            self.checkouts.append(item as! Checkout)
            fullfill(item)
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fullfill, reject in
            fatalError()
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fullfill, reject in
            fatalError()
        }
    }

}
