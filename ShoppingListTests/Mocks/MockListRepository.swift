//
//  MockItemOnListRepositoy.swift
//  ShoppingListTests
//
//  Created by Paulo José on 21/05/21.
//

import Foundation
import Promises
@testable import ShoppingList

class MockListRepository: ICRUDRepository {

    var errorMock = false
    var list: [List] = [
        List("name")
    ]
    
    func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
        return Promise { fullfill, reject in
            guard let list = (self.list.first { $0.uuid == uuid})  else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            fullfill(list as! T)
        }
    }
    
    func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
        return Promise { fulfill, reject in
            fatalError()
        }
    }
    
    
    func create<T: Fetchable>(_ item: T) -> Promise<T> {
        return Promise { fullfill, reject in
            
            if (self.errorMock) {
                reject(ICRUDRepositoryError.errorOnOperaration)
                return
            }
            
            self.list.append(item as! List)
            fullfill(item)
        }
    }
    
    func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fullfill, reject in
            self.list.append(item as! List)
            fullfill(item)
        }
    }
    
    func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
        return Promise { fullfill, reject in
            self.list.append(item as! List)
            fullfill(true)
        }
    }

}
