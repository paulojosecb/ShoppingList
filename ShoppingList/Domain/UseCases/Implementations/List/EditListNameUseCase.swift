//
//  EditListNameUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 26/05/21.
//

import Foundation
import Promises

class EditListNameUseCase: IEditListNameUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IEditListNameUseCaseRequest) -> Promise<IEditListNameUseCaseResponse> {
        
        return Promise<IEditListNameUseCaseResponse> { fulfill, reject in
            
            if (request.name != "") {
                reject(IEditListNameUseCaseError.invalidName)
                return
            }
            
            self.repository.fetch(uuid: request.uuid)
                .then { (list: List) -> Promise<List> in
                    list.name = request.name
                    return self.repository.update(list)
                }
                .then { list in
                    fulfill(.init(list: list))
                }
                .catch { error in
                    if let err = error as? ICRUDRepositoryError,
                       err == .notFound {
                        reject(IEditListNameUseCaseError.listNotFound)
                        return
                    } else {
                        reject(IEditListNameUseCaseError.unknownError)
                        return
                    }
                }
            
        }
        
    }
}
