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
    var checkout: [Checkout] = []
    
    func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
        return Promise { fullfill, reject in
            let checkout = self.checkout.filter { $0.uuid == uuid}
            fullfill(checkout.first as! T)
        }
    }
    
    func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    
    func create<T: Fetchable>(_ item: T) -> Promise<T> {
        return Promise { fullfill, reject in
            self.checkout.append(item as! Checkout)
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
