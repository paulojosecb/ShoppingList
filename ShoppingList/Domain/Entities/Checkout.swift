//
//  Checkout.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation

class Checkout: Fetchable {
    var uuid: String
    let listUUID: String
    let items: [ItemOnList]
    let location: Location?
    let date: Date
    let total: Double
    
    init(listUUID: String, items: [ItemOnList], total: Double, date: Date, location: Location?, uuid: String = UUID().uuidString) {
        self.uuid = uuid
        self.listUUID = listUUID
        self.items = items
        self.location = location
        self.date = date
        self.total = total
    }
    
}
