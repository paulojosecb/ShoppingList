//
//  IListViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 18/06/21.
//

import Foundation
import Promises

protocol IListViewModel {
    var list: List { get }
    var itensOnList: [ItemOnList] { get }
    
    func create(item: Item) -> Promise<Item>
    func fetch(list: List) -> Promise<List>
    func checkout(list: List) -> Promise<Checkout>
}
