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
        
        let cdItemPrice = cdItemOnList.item?.prices?.lastObject as? CDItemPrice
    
        let itemOnList = ItemOnList(item: Item.make(from: cdItemOnList.item!),
                                    on: cdItemOnList.list!.uuid!,
                                    quantity: Int(cdItemOnList.quantity),
                                    unitPrice: ItemPrice.make(from: cdItemPrice),
                                    uuid: cdItemOnList.uuid)
        
        return itemOnList
    }
    
    static func make(from itemOnList: ItemOnList, cdItemOnList: CDItemOnList, cdItem: CDItem, cdList: CDList) -> CDItemOnList {
        
        cdItemOnList.item = cdItem
        cdItemOnList.list = cdList
        cdItemOnList.uuid = itemOnList.uuid
        cdItemOnList.quantity = Int16(itemOnList.quantity)
        
        return cdItemOnList
    }
    
}

extension List {
    
    static func make(from cdList: CDList) -> List {
        
        guard let items = cdList.items?.array as? [CDItemOnList],
              let cart = cdList.cart?.array as? [CDItemOnList] else {
            fatalError()
        }
    
        
        return List(uuid: cdList.uuid!,
                    name: cdList.name!,
                    items: items.map { ItemOnList.make(from: $0)},
                    cart: cart.map { ItemOnList.make(from: $0)},
                    isTempl: cdList.isTemplate)
    }
    
}



extension ItemPrice {
    
    static func make(from cdItemPrice: CDItemPrice?) -> ItemPrice? {
        guard let cdItemPrice = cdItemPrice else {
            return nil
        }
        
        return ItemPrice(price: cdItemPrice.price,
                         location: Location.make(from: cdItemPrice.location), timeStamp: cdItemPrice.timeStamp!)
    }
    
}

extension Location {
    
    static func make(from cdLocation: CDLocation?) -> Location? {
        return cdLocation != nil ? Location(latitude: cdLocation!.latitude,
        longitude: cdLocation!.longitude) : nil
    }
    
}
