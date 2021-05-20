//
//  Item+CDItem.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation

extension Item {
    
    static func make(from cdItem: CDItem) -> Item {
                
        let item = Item(name: cdItem.name ?? "",
                        isBulk: cdItem.isBulk,
                        prices: cdItem.prices as? [ItemPrice] ?? [],
                        uuid: cdItem.uuid ?? "")
        
        return item
    }
    
    static func make(from item: Item, cdItem: CDItem) -> CDItem {
        
        cdItem.uuid = item.uuid
        cdItem.isBulk = item.isBulk
        cdItem.name = item.name
        cdItem.prices = item.prices as NSObject

        return cdItem
    }
}
