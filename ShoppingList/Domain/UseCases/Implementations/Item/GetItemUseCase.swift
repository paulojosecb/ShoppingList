//
//  GetItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

enum IGetItemUseCaseRepositoryError: Error {
    case itemNotFound
}

protocol IGetItemUseCaseRepository {

}

class GetItemUseCase {
    var repository: ICRUDRepository
        
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
//    func execute(request: IGetItemUseCaseRequest, completion: @escaping (Result<IGetItemUseCaseResponse, IGetItemUseCaseError>) -> Void) {
//
//        do {
//
//            try self.fetch(uuid: request.uuid, next: { (item: Item) in
//                completion(.success(.init(item: item)))
//            })
//
//        } catch ICRUDTemplateUseCaseError.notFound {
//            completion(.failure(.itemNotFound))
//        } catch ICRUDTemplateUseCaseError.errorOnOperaration {
//            completion(.failure(.unknownError))
//        } catch let error {
//
//            guard let error = error as? IGetItemUseCaseError else {
//                completion(.failure(.unknownError))
//                return
//            }
//
//            completion(.failure(error))
//
//        }
//    }
    
}
