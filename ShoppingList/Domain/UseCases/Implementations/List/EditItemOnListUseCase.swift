//
//  EditItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 21/05/21.
//

import Foundation
import Promises

class EditItemOnListUseCase: IEditItemOnListUseCase {
    
    let itemOnListRepository: ICRUDRepository
    let listRepository: ICRUDRepository
    
    init(itemOnListRepository: ICRUDRepository, listRepository: ICRUDRepository) {
        self.itemOnListRepository = itemOnListRepository
        self.listRepository = listRepository
    }
    
    func execute(request: IEditItemOnListUseCaseRequest) -> Promise<IEditListNameUseCaseResponse> {
        
        return Promise<IEditListNameUseCaseResponse> { fulfill, reject in
            
            if (request.newQuantity <= 0) {
                reject(IEditItemOnListUseCaseError.invalidQuantity)
                return
            }
            
            self.itemOnListRepository.fetch(uuid: request.itemOnListUUID)
                .then { (itemOnList: ItemOnList) -> Promise<ItemOnList> in
                    itemOnList.quantity = request.newQuantity
                    return self.itemOnListRepository.update(itemOnList)
                }
                .then { (itemOnList) -> Promise<List> in
                    self.listRepository.fetch(uuid: request.listUUID)
                }.then { (list)  in
                    fulfill(.init(list: list))
                }
                .catch { (_) in
                    reject(IDeleteListUseCaseError.unknownError)
                }
            
        }
        
    }
}
