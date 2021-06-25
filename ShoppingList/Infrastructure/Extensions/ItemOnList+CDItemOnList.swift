//
//  ItemOnList+CDItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import Foundation
import CoreData

extension ItemOnList {
    
    static func make(from cdItemOnList: CDItemOnList) -> ItemOnList {
        let itemOnList = ItemOnList(item: Item.make(from: cdItemOnList.item!),
                                    on: cdItemOnList.listUUID!,
                                    quantity: Int(cdItemOnList.quantity),
                                    unitPrice: cdItemOnList.unitPrice as? ItemPrice,
                                    uuid: cdItemOnList.uuid)
        
        return itemOnList
    }
    
    static func make(from itemOnList: ItemOnList, cdItemOnList: CDItemOnList, cdItem: CDItem) -> CDItemOnList {
        
        cdItemOnList.item = Item.make(from: itemOnList.item, cdItem: cdItem)
        cdItemOnList.listUUID = itemOnList.listUUID
        cdItemOnList.uuid = itemOnList.uuid
        cdItemOnList.quantity = Int16(itemOnList.quantity)
        cdItemOnList.unitPrice = itemOnList.unitPrice
        
        return cdItemOnList
    }
    
}
