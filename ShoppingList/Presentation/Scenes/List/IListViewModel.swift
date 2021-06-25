//
//  IListViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 18/06/21.
//

import Foundation

protocol IListViewModel {
    
    var items: [ItemOnList: Item] { get }
    
}
