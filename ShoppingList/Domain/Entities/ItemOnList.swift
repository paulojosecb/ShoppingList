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

    init(item: String, on list: String, quantity: Int, uuid: String = UUID().uuidString) {
        self.uuid = uuid
        self.itemUUID = item
        self.listUUID = list
        self.quantity = quantity
    }
}
