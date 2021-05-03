//
//  List.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class List: Fetchable {
    var uuid: String
    var name: String
    var items: [ItemOnList]
    var cart: Cart
    
    init(name: String) {
        self.uuid = UUID().uuidString
        self.name = name
        self.items = []
        self.cart = Cart(listUUID: self.uuid)
    }
    
}
