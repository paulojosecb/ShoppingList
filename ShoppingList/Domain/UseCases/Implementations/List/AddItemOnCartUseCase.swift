//
//  AddItemOnCartUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation
import Promises

class AddItemOnCartUseCase: IAddItemOnCartUseCase {
    
    var repository: ICRUDRepository

    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IAddItemOnCartUseCaseRequest) -> Promise<IAddItemOnCartUseCaseResponse> {
        
        return Promise<IAddItemOnCartUseCaseResponse> { fulfill, reject in
            
            if (request.quantity == 0) {
                reject(IAddItemOnCartUseCaseError.invalidQuantity)
                return
            }
            
            self.repository.fetch(uuid: request.listUUID).then { (list: List) in
                
                do {
                    try list.moveItemToCart(itemUUID: request.itemUUID)
                } catch _ {
                    reject(IAddItemOnCartUseCaseError.itemNotInList)
                }
                
                
            }.then { (list: List) in
                self.repository.update(list).catch { (error) in
                    reject(error)
                }
            }.catch { (_) in
                reject(IAddItemOnCartUseCaseError.listNotFound)
            }
        
        }
        
    }
    
}
