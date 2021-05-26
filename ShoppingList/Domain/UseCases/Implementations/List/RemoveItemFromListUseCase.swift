//
//  RemoveItemFromListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 26/05/21.
//

import Foundation
import Promises

class RemoveItemFromListUseCase: IRemoveItemFromListUseCase {
    
    let itemOnListRepository: IItemOnListRepository
    let listRepository: ICRUDRepository
    
    init(itemOnListRepository: IItemOnListRepository, listRepository: ICRUDRepository) {
        self.itemOnListRepository = itemOnListRepository
        self.listRepository = listRepository
    }
    
    func execute(request: IRemoveItemFromListUseCaseRequest) -> Promise<IRemoveItemFromListUseCaseResponse> {
        
        return Promise<IRemoveItemFromListUseCaseResponse> { fulfill, reject in
            
            self.listRepository.fetch(uuid: request.listUUID)
                .then { (list: List) -> Promise<List> in
                    list.removeItemFromList(itemUUID: request.itemUUID)
                    return self.listRepository.update(list)
                }
                .then { list in
                    fulfill(.init(list: list))
                }
                .catch { error in
                    
                    if let err = error as? List.CustomError,
                       err == .itemNotFoundOnList {
                        reject(IRemoveItemFromListUseCaseError.itemNotOnList)
                        return
                    }
                                    
                    reject(IRemoveItemFromListUseCaseError.itemNotFound)
                    return
                }
            
        }
        
    }
    
    
}
