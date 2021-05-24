//
//  GetItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 24/05/21.
//

import Foundation
import Promises

class GetItemUseCase: IGetItemUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IGetItemUseCaseRequest) -> Promise<IGetItemUseCaseResponse> {
        return Promise { fulfill, reject in
            
            self.repository.fetch(uuid: request.uuid)
                .then { (item: Item) in
                    fulfill(.init(item: item))
                }.catch { _ in
                    reject(IGetItemUseCaseError.itemNotFound)
                }
            
        }
    }
    
}
