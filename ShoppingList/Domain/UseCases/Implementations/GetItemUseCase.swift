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
    func fetchItemFor(uuid: UUID, completion: @escaping(Result<Item, IGetItemUseCaseRepositoryError>) -> Void)
}

class GetItemUseCase: IGetItemUseCase {
    
    let repository: IGetItemUseCaseRepository
    
    init(repository: IGetItemUseCaseRepository) {
        self.repository = repository
    }
    
    func execute(request: IGetItemUseCaseRequest, completion: @escaping (Result<IGetItemUseCaseResponse, IGetItemUseCaseError>) -> Void) {
        
        self.repository.fetchItemFor(uuid: request.uid) { (result) in
            switch result {
            case .success(let item):
                let response = IGetItemUseCaseResponse(item: item)
                completion(.success(response))
            case .failure(let error):
                switch error {
                case .itemNotFound:
                    completion(.failure(.itemNotFound))
                }
            }
        }
        
    }
}
