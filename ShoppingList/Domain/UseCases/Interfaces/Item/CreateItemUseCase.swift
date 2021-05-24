//
//  CreateItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 24/05/21.
//

import Foundation
import Promises

class CreateItemUseCase: ICreateItemUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: ICreateItemUseCaseRequest) -> Promise<ICreateItemUseCaseResponse> {
        
        return Promise { fulfill, reject in
            
            if (request.item.name == "") {
                reject(ICreateItemUseCaseError.invalidName)
            }
            
            self.repository.create(request.item)
                .then { (item) in
                    fulfill(.init(item: item))
                }.catch { (error) in
                    reject(ICreateItemUseCaseError.unknownError)
                }
        }
    }
    
}
