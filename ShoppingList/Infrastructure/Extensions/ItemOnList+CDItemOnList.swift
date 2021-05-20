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
        let itemOnList = ItemOnList(item: cdItemOnList.itemUUID!,
                                    on: cdItemOnList.listUUID!,
                                    quantity: Int(cdItemOnList.quantity),
                                    uuid: cdItemOnList.uuid)
        
        return itemOnList
    }
    
    static func make(from itemOnList: ItemOnList, cdItemOnList: CDItemOnList) -> CDItemOnList {
        
        cdItemOnList.itemUUID = itemOnList.itemUUID
        cdItemOnList.listUUID = itemOnList.listUUID
        cdItemOnList.uuid = itemOnList.uuid
        cdItemOnList.quantity = Int16(itemOnList.quantity)
        
        return cdItemOnList
    }
    
}
