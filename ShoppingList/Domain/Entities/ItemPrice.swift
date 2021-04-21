//
//  Price.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

class ItemPrice {
    let price: Double
    let timeStamp: Date
    let location: Location
    
    init(price: Double, location: Location, timeStamp: Date) {
        self.price = price
        self.location = location
        self.timeStamp = timeStamp
    }
}
