//
//  List.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

class List: Fetchable {
    
    enum CustomError: Error {
        case invalidListUUID
        case itemNotFoundOnList
        case itemNotFoundOnCart
        case itemAlreadyOnList
        case itemAlreadyOnCart
    }
    
    var uuid: String
    
    var name: String
    
    private var items: [ItemOnList]
    var cart: Cart
    
    init(_ nam: String) {
        self.uuid = UUID().uuidString
        self.items = []
        self.cart = Cart(listUUID: self.uuid)
        self.name = nam
    }
    
    init(uuid: String, name: String, items: [ItemOnList], cart: Cart) {
        self.uuid = uuid
        self.name = name
        self.items = items
        self.cart = cart
    }
    
    public func addItemToList(_ item: ItemOnList) throws {
        if (item.listUUID == self.uuid) {
            
            if (!doesListContain(itemUUID: item.itemUUID) && !doesCartContain(itemUUID: item.itemUUID)) {
                self.items.append(item)
            } else {
                throw List.CustomError.itemAlreadyOnList
            }
            
        } else {
            throw List.CustomError.invalidListUUID
        }
    }
    
    public func moveItemToCart(itemUUID: String) throws {
        
        if (doesCartContain(itemUUID: itemUUID)) {
            throw List.CustomError.itemAlreadyOnCart
        }
        
        if (!doesListContain(itemUUID: itemUUID)) {
            throw List.CustomError.itemNotFoundOnList
        }
        
        guard let item = self.getItemFromList(itemUUID: itemUUID) else {
            throw List.CustomError.itemNotFoundOnList
        }
        
        self.removeItemFromList(itemUUID: itemUUID)
        self.cart.items.append(item)

    }
    
    public func moveItemOutOfCart(itemUUID: String) throws {
        
        if (!doesCartContain(itemUUID: itemUUID)) {
            throw List.CustomError.itemNotFoundOnCart
        }
                    
        guard let item = self.getItemFromCart(itemUUID: itemUUID) else {
            throw List.CustomError.itemNotFoundOnCart
        }
        
        self.removeItemFromCart(itemUUID: itemUUID)
        self.items.append(item)
    }
    
    public func removeItemFromList(itemUUID: String) {
        self.items = self.items.filter { $0.itemUUID != itemUUID }
    }
    
    public func getItemsFromList() -> [ItemOnList] {
        return self.items
    }
    
    public func getItemsFromCart() -> [ItemOnList] {
        self.cart.items
    }
    
    private func removeItemFromCart(itemUUID: String) {
        self.cart.items = self.cart.items.filter { $0.itemUUID != itemUUID }
    }
    
    private func doesListContain(itemUUID: String) -> Bool {
        return self.items.filter { $0.itemUUID == itemUUID }.count > 0
    }
    
    private func doesCartContain(itemUUID: String) -> Bool {
        return self.cart.items.filter { $0.itemUUID == itemUUID }.count > 0
    }
    
    private func getItemFromList(itemUUID: String) -> ItemOnList? {
        return self.items.first { $0.itemUUID == itemUUID }
    }
    
    private func getItemFromCart(itemUUID: String) -> ItemOnList? {
        return self.cart.items.first { $0.itemUUID == itemUUID }
    }
    
}
