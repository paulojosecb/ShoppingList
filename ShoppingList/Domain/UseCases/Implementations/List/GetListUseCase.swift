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
            
            if request.uuid != nil {
                
                self.repository.fetch(uuid: request.uuid!)
                    .then { (list: List) in
                        
                        fulfill(.init(lists: [list]))
                        
                    }
                    .catch { _ in
                        reject(IGetListUseCaseError.listNotFound)
                    }
                
            } else {
                
                self.repository.fetch()
                    .then { lists in
                        fulfill(.init(lists: lists))
                    }
                    .catch { _ in
                        reject(IGetListUseCaseError.unknownError)
                    }
                
            }
            
            
        }
        
    }
    
    
}
