//
//  DeleteListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/05/21.
//

import Foundation
import Promises

class DeleteListUseCase: IDeleteListUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IDeleteListUseCaseRequest) -> Promise<IDeleteListUseCaseResponse> {
        return Promise { fulfill, reject in
            
            self.repository.fetch(uuid: request.uuid).then { (list: List) -> Promise<Bool> in
                return self.repository.delete(list)
            }.then { (deleted) in
                fulfill(.init(deleted: deleted))
            }.catch { (error) in
                guard let error = error as? ICRUDRepositoryError else {
                    reject(IDeleteListUseCaseError.unknownError)
                    return
                }
                
                switch error {
                case .errorOnOperaration:
                    reject(IDeleteListUseCaseError.unknownError)
                case .notFound:
                    reject(IDeleteListUseCaseError.listNotFound)
                }
                                        
            }
            
        }
    }
    
}
