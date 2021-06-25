//
//  AddItemOnListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/05/21.
//

import Foundation
import Promises

class AddItemOnListUseCase: IAddItemOnListUseCase {
    
    let listRepository: ICRUDRepository
    let itemRepository: ICRUDRepository
    
    init(listRepository: ICRUDRepository, itemRepository: ICRUDRepository) {
        self.listRepository = listRepository
        self.itemRepository = itemRepository
    }
    
    func execute(request: IAddItemOnListUseCaseRequest) -> Promise<IAddItemOnListUseCaseResponse> {
        
        return Promise { fulfill, reject in
            
            if (request.quantity == 0) {
                reject(IAddItemOnListUseCaseError.invalidQuantity)
                return
            }
            
            var item: Item? = nil
            
            self.itemRepository.fetch(uuid: request.item.uuid).then { (it: Item) -> Promise<List> in
                item = it
                return self.listRepository.fetch(uuid: request.listUUID)
            }.then { (list: List) -> Promise<List> in
                
                let itemOnList = ItemOnList(item: request.item,
                                            on: request.listUUID,
                                            quantity: request.quantity,
                                            unitPrice: item?.prices.last,
                                            uuid: nil)
                
                do {
                    try list.addItemToList(itemOnList)
                } catch let error {
                    
                    if error is List.CustomError {
                        reject(IAddItemOnListUseCaseError.itemAlreadyOnList)
                    } else {
                        reject(IAddItemOnListUseCaseError.unknownError)
                    }
                    
                }
                
                return self.listRepository.update(list)
            }.then { (list) in
                fulfill(.init(list: list))
            }.catch { _ in
                reject(IAddItemOnListUseCaseError.itemNotFound)
            }
        
        }

    }
    
    
}
