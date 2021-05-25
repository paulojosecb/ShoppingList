//
//  GetListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 25/05/21.
//

import Foundation
import Promises


class GetListUseCase: IGetListUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IGetListUseCaseRequest) -> Promise<IGetListUseCaseResponse> {
        
        return Promise<IGetListUseCaseResponse> { fulfill, reject in
            
            self.repository.fetch(uuid: request.uuid)
                .then { (list: List) in
                    
                    fulfill(.init(list: list))
                    
                }
                .catch { _ in
                    reject(IGetListUseCaseError.listNotFound)
                }
            
        }
        
    }
    
    
}
