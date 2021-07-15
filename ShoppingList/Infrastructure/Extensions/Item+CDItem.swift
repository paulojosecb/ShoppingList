//
//  Item+CDItem.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation

extension Item {
    
    static func make(from cdItem: CDItem) -> Item {
        
        guard let cdPrices = cdItem.prices?.array as? [CDItemPrice] else {
            fatalError()
        }
        
        let prices: [ItemPrice] = cdPrices.map { ItemPrice.make(from: $0)! }
                
        let item = Item(name: cdItem.name ?? "",
                        isBulk: cdItem.isBulk,
                        prices: prices,
                        uuid: cdItem.uuid ?? "")
        
        return item
    }

}
