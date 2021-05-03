//
//  ItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class ItemOnList: Fetchable {
    let uuid: String
    var quantity: Int
    let itemUUID: String
    let listUUID: String

    init(item: Item, on list: List, quantity: Int, uuid: String) {
        self.uuid = uuid
        self.item = item
        self.list = list
        self.quantity = quantity
    }
}
