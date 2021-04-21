//
//  AddItemPriceUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation


class AddItemPriceUseCase: IAddItemPriceUseCase, ICRUDTemplateUseCase {

    var repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IAddItemPriceUseCaseRequest, completion: @escaping (Result<IAddItemPriceUseCaseResponse, IAddItemPriceUseCaseError>) -> Void) {
        
        if (request.newPrice <= 0.0) {
            completion(.failure(.priceInvalid))
            return
        }
        
        do {
            
            try self.fetch(uuid: <#T##UUID#>, next: <#T##(Fetchable) throws -> ()#>)
            
            try self.fetchItemFor(uuid: request.itemUUID) { (item) in
                
                try self.add(price: request.newPrice, item: item) { (item) in
                    
                    try self.update(item: item) { (item) in
                        completion(.success(.init(item: item)))
                    }
                    
                }
            }
            
        } catch let error {
            
            guard let error = error as? IAddItemPriceUseCaseError else {
                completion(.failure(.unknownError))
                return
            }
            
            completion(.failure(error))
        }
        
    }
    
}
