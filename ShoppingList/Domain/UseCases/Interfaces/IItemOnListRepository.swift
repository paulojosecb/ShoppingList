//
//  IItemOnListRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 26/05/21.
//

import Foundation
import Promises

protocol IItemOnListRepository: ICRUDRepository {
    func fetchBy(listUUID: String, itemUUID: String) -> Promise<ItemOnList>
}
