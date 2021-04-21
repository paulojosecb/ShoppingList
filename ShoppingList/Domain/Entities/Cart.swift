//
//  Cart.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

class Cart: List {
    let listUUID: UUID
    
    init(listUUID: UUID) {
        self.listUUID = listUUID
        super.init(name: "")
    }
}
