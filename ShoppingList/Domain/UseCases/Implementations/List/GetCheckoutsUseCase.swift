//
//  GetCheckoutsUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises

class GetCheckoutsUseCase: IGetCheckoutsUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IGetCheckoutsUseCaseRequest) -> Promise<IGetCheckoutsUseCaseResponse> {
        
        return Promise { fulfill, reject in
            
            if (request.uuid == nil) {
                self.repository.fetch()
                    .then { (checkouts: [Checkout]) in
                        fulfill(.init(checkouts: checkouts))
                    }
                    .catch { _ in
                        reject(IGetCheckoutsUseCaseError.unknownError)
                    }
            } else {
                self.repository.fetch(uuid: request.uuid!)
                    .then { (checkout: Checkout) in
                        fulfill(.init(checkouts: [checkout]))
                    }
                    .catch { _ in
                        reject(IGetCheckoutsUseCaseError.checkoutNotFound)
                    }
                    
            }
            
        }
        
    }
    
}
