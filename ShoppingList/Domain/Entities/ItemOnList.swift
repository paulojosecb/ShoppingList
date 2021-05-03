//
//  ItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class ItemOnList: Fetchable {
    let uuid: UUID
    var quantity: Int
    let itemUUID: String
    let listUUID: String
    
<<<<<<< Updated upstream
    init(item: Item, on list: List, quantity: Int, uuid: UUID) {
        self.uuid = uuid
        self.item = item
        self.list = list
=======
    init(item: String, on list: String, quantity: Int) {
        self.uuid = UUID().uuidString
        self.itemUUID = item
        self.listUUID = list
>>>>>>> Stashed changes
        self.quantity = quantity
    }
}
