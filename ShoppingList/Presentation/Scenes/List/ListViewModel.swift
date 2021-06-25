//
//  ListViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 18/06/21.
//

import Foundation
import Promises

class ListViewModel: IListViewModel {

    let list: List
    let itensOnList: [ItemOnList]
    
    let createItemUseCase: CreateItemUseCase
    let getListUseCase: GetListUseCase
    let checkoutUseCase: CheckoutUseCase
    
    init(list: List) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        
        let listRepository = ListRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        let itemRepository = ItemRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        let checkoutRepository = CheckoutRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        
        self.createItemUseCase = CreateItemUseCase(repository: itemRepository)
        self.getListUseCase = GetListUseCase(repository: listRepository)
        self.checkoutUseCase = CheckoutUseCase(listRepository: listRepository, checkoutRepository: checkoutRepository)
        
        self.list = list
        self.itensOnList = list.getItemsFromList()
    }
    
    func create(item: Item) -> Promise<Item> {
        return Promise { fulfill, reject in
            
        }
    }
    
    func fetch(list: List) -> Promise<List> {
        return Promise { fulfill, reject in
            
        }
    }
    
    func checkout(list: List) -> Promise<Checkout> {
        return Promise { fulfill, reject in
            
        }
    }
}
 
