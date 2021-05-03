//
//  Cart.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

class Cart {
    var uuid: String
    var listUUID: String
    var items: [ItemOnList]
    
    init(listUUID: String) {
        self.uuid = UUID().uuidString
        self.listUUID = listUUID
        self.items = []
    }
}
