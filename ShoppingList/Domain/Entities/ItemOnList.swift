//
//  ItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class ItemOnList {
    let uuid: UUID
    let quantity: Int
    let item: Item
    let list: List
    
    init(item: Item, on list: List, quantity: Int, uuid: UUID) {
        self.uuid = uuid
        self.item = item
        self.list = list
        self.quantity = quantity
    }
}
