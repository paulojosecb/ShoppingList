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
            
            self.repository.fetch(uuid: request.listUUID).then { (list: List) in
                
                do {
                    try list.moveItemToCart(itemUUID: request.itemUUID)
                } catch let error {
                    reject(IAddItemOnCartUseCaseError.itemNotInList)
                }
                
                
            }.then { (list: List) in
                self.repository.update(list)
            }.then { (list: List) in
                fulfill(.init(list: list))
            }.catch { _ in
                reject(IAddItemOnCartUseCaseError.itemNotInList)
            }
                    
        
        }
        
    }
    
}
