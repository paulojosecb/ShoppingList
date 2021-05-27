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
    let unitPrice: ItemPrice?

    init(item: String, on list: String, quantity: Int, unitPrice: ItemPrice?, uuid: String?) {
        self.uuid = uuid ?? UUID().uuidString
        self.itemUUID = item
        self.listUUID = list
        self.quantity = quantity
        self.unitPrice = unitPrice
    }
}
