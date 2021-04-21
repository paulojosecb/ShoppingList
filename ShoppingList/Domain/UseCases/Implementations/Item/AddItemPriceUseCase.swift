//
//  AddItemPriceUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

protocol IAddItemPriceUseCaseRepository: IRepository {
    
}

class AddItemPriceUseCase: IAddItemPriceUseCase {

    
    let repository: IAddItemPriceUseCaseRepository
    
    init(repository: IAddItemPriceUseCaseRepository) {
        self.repository = repository
    }
    
    func execute(request: IAddItemPriceUseCaseRequest, completion: @escaping (Result<IAddItemPriceUseCaseResponse, IAddItemPriceUseCaseError>) -> Void) {
        
        if (request.newPrice <= 0.0) {
            completion(.failure(.priceInvalid))
            return
        }
        
        do {
            
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
    
    private func fetchItemFor(uuid: UUID, next: @escaping (Item) throws -> ()) throws {
        
        self.repository.fetch(uuid: uuid) { (result: Result<Item, IRepositoryError>) in
            switch result {
            case .success(let item):
                try next(item)
            case .failure(let error):
                throw self.handle(error: error)
            }
        }
        
    }
    
    private func add(price: Double, item: Item, next: @escaping (Item) throws -> ()) throws {
        
        item.prices.append(getNewPrice(for: price))
        try next(item)
        
    }
    
    private func update(item: Item, next: @escaping (Item) throws -> ()) throws {
        
        self.repository.update(item) { (result) in
            
            switch result {
            case .success(let item):
                try next(item)
            case .failure(let error):
                throw self.handle(error: error)
            }
        }
        
    }
    
    private func getNewPrice(for price: Double) -> ItemPrice {
        return ItemPrice(price: price,
                         location: Location(latitude: 0, longitude: 0),
                         timeStamp: Date())
    }
    
    private func handle(error: IRepositoryError) -> IAddItemPriceUseCaseError {
        switch error {
        case .notFound:
            return .itemNotFound
        default:
            return .unknownError
        }
    }
    
}
