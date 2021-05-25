//
//  AddItemPriceUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 25/05/21.
//

import Foundation
import Promises

class AddItemPriceUseCase: IAddItemPriceUseCase {

    let repository: IItemRepository
    
    init(repository: IItemRepository) {
        self.repository = repository
    }
    
    func execute(request: IAddItemPriceUseCaseRequest) -> Promise<IAddItemPriceUseCaseResponse> {
        
        return Promise<IAddItemPriceUseCaseResponse> { fulfill, reject in
            
            if (request.newPrice <= 0) {
                reject(IAddItemPriceUseCaseError.priceInvalid)
            }
            
            self.repository.fetch(uuid: request.itemUUID).then { (item: Item) -> Promise<Item> in
                
                item.prices.append(ItemPrice(price: request.newPrice,
                                             location: request.location,
                                             timeStamp: Date()))
                
                return self.repository.update(item)
            }.then { (item: Item) in
                fulfill(.init(item: item))
            }
            .catch { error in
                reject(IAddItemPriceUseCaseError.itemNotFound)
            }
            
        }
        
    }
}
