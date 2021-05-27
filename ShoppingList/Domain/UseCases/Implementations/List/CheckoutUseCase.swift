//
//  CheckoutUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises

class CheckoutUseCase: ICheckoutUseCase {
    
    let listRepository: ICRUDRepository
    let checkoutRepository: ICRUDRepository
    
    init(listRepository: ICRUDRepository, checkoutRepository: ICRUDRepository) {
        self.listRepository = listRepository
        self.checkoutRepository = checkoutRepository
    }
    
    func execute(request: ICheckoutUseCaseRequest) -> Promise<ICheckoutUseCaseResponse> {
        
        return Promise { fulfill, reject in
            self.listRepository.fetch(uuid: request.listUUID)
                .then { (list: List) -> Promise<Checkout> in
                    let checkout = Checkout(listUUID: list.uuid,
                                            items: list.getItemsFromList(),
                                            total: list.total,
                                            date: request.date,
                                            location: request.location)
                    
                    return self.checkoutRepository.create(checkout)
                }
                .then { checkout in
                    fulfill(.init(checkout: checkout))
                }
                .catch { _ in
                    reject(ICheckoutUseCaseError.listNotFound)
                }
        }
        
    }
    
    
}
