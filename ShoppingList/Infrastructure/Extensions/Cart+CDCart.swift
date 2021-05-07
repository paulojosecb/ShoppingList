//
//  CDCart+toCart.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import Foundation

extension Cart {
    
    static func make(from cdCart: CDCart, and items: [CDItemOnList]) -> Cart {
        let cart = Cart(listUUID: cdCart.listUUID!)
        cart.listUUID = cdCart.listUUID!
        cart.items = items.map({ (cdItemOnList) in
            return ItemOnList.make(from: cdItemOnList)
        })
        
        return cart
    }
    
    static func make(from cart: Cart, cdCart: CDCart) -> CDCart {
        
        cdCart.uuid = cart.uuid
        cdCart.listUUID = cart.listUUID
        
        cdCart.items = cart.items.map { (itemOnList) in
            return itemOnList.uuid
        } as NSObject
        
        return cdCart
        
    }
    
}
