//
//  CreateListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 22/04/21.
//

import Foundation
import Promises

class CreateListUseCase: ICreateListUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: ICreateListUseCaseRequest) -> Promise<ICreateListUseCaseResponse> {
        
        let promise = Promise<ICreateListUseCaseResponse> { fulfill, reject in
            
            self.repository.create(List(name: request.name)).then { list in
                fulfill(.init(list: list))
            }.catch { (error) in
                reject(self.handle(error))
            }
            
        }
        
        return promise
    }
    
    private func handle(_ error: Error) -> ICreateListUseCaseError {
        guard let error = error as? ICRUDRepositoryError else {
            return .unknownError
        }
        
        switch error {
        case .errorOnOperaration:
            return .unknownError
        default:
            return .unknownError
        }
    }
    
    
}
