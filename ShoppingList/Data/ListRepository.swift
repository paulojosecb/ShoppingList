//
//  MainDataRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 03/05/21.
//

import Foundation
import Promises

class ListRepository: ICRUDRepository {
    
    var list: [List] = []
    
    func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            guard let list = (self.list.first { $0.uuid == uuid}) as? T  else {
                reject(ICRUDRepositoryError.notFound)
                return
            }
            
            fulfill(list)
        }
    }
    
    func create<T>(_ item: T) -> Promise<T> where T : Fetchable {
        return Promise { fulfill, reject in
            self.list.append(item as! List)
            fulfill(item)
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
            self.list = self.list.filter { $0.uuid != item.uuid }
            
            fulfill(true)
        }
    }
    
}
