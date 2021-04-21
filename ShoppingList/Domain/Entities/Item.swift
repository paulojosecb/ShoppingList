//
//  Item.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class Item: Fetchable {
    var uuid: UUID
    var name: String
    var prices: [ItemPrice]
    var isBulk: Bool
    
    init(name: String, isBulk: Bool = false, initialPrice: ItemPrice?, uuid: UUID) {
        self.name = name
        self.isBulk = isBulk
        
        if let initialPrice = initialPrice {
            self.prices = [initialPrice]
        } else {
            self.prices = []
        }
            
        self.uuid = uuid
    }
}
