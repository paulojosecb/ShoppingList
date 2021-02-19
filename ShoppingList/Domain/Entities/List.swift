//
//  List.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class List {
    var uid: UUID
    var name: String
    var items: [ItemOnList]
    var cart: List?
    var isCart: Bool
    
    init(name: String) {
        self.uid = UUID()
        self.name = name
        self.items = []
        self.cart = List(listName: name)
        self.isCart = false
    }
    
    init(listName: String) {
        self.uid = UUID()
        self.name = "Cart of \(listName)"
        self.items = []
        self.cart = nil
        self.isCart = true
    }
}
