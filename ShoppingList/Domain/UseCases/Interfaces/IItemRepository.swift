//
//  IItemRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation
import Promises

protocol IItemRepository: ICRUDRepository {
    func fetchBy<T: Fetchable>(name: String) -> Promise<[T]>
}
