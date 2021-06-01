//
//  SearchForItemsUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation
import Promises

class SearchForItemsUseCase: ISearchForItemsUseCase {
    
    var repository: IItemRepository

    init(repository: IItemRepository) {
        self.repository = repository
    }
    
    
    func execute(request: ISearchForItemsUseCaseRequest) -> Promise<ISearchForItemsUseCaseResponse> {
        
        return Promise<ISearchForItemsUseCaseResponse> { fulfill, reject in
            
            if (request.query == "") {
                reject(ISearchForItemsUseCaseError.invalidQuery)
                return
            }
         
            self.repository.fetchBy(name: request.query).then { items in
                fulfill(.init(item: items))
            }.catch { (_) in
                reject(ISearchForItemsUseCaseError.itemNotFound)
            }
            
        }
        
    }
    
    
}
