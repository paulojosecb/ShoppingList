//
//  EditItemOnCartUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

class EditItemOnCartUseCase: IEditItemOnCartUseCase, ICRUDTemplateUseCase {
    var repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IEditItemOnCartUseCaseRequest, completion: @escaping (Result<IEditItemOnCartUseCaseResponse, IEditItemOnCartUseCaseError>) -> Void) {
        
        do {
            
            try self.fetch(uuid: request.listUUID) { (list: List) in
                
                try self.setQuantityOf(item: request.itemUUID, of: list, to: request.quantity, next: { (list) in
                    
                    try self.update(list, next: { (list) in
                        completion(.success(.init(list: list)))
                    })
                    
                })
            }
            
        } catch ICRUDTemplateUseCaseError.notFound {
            completion(.failure(.itemNotFound))
        } catch ICRUDTemplateUseCaseError.errorOnOperaration {
            completion(.failure(.unknownError))
        } catch let error {
            
            guard let error = error as? IEditItemOnCartUseCaseError else {
                completion(.failure(.unknownError))
                return
            }
            
            completion(.failure(error))
            
        }
        
    }
    
    private func setQuantityOf(item uuid: UUID, of list: List, to quantity: Int, next: @escaping (List) throws -> Void) throws {
        
        let itemOnList = list.items.filter { $0.item.uuid == uuid }.first
        itemOnList?.quantity = quantity
    
        try next(list)
    }
    
}
