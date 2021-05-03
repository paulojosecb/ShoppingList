////
////  AddItemPriceUseCase.swift
////  ShoppingList
////
////  Created by Paulo José on 21/04/21.
////
//
//import Foundation
//
//
//class AddItemPriceUseCase: IAddItemPriceUseCase {
//
//    var repository: ICRUDRepository
//    
//    init(repository: ICRUDRepository) {
//        self.repository = repository
//    }
//    
//    func execute(request: IAddItemPriceUseCaseRequest, completion: @escaping (Result<IAddItemPriceUseCaseResponse, IAddItemPriceUseCaseError>) -> Void) {
//        
//        if (request.newPrice <= 0.0) {
//            completion(.failure(.priceInvalid))
//            return
//        }
//        
//        do {
//            
//            try self.fetch(uuid: request.itemUUID, next: { (item: Item) in
//                
//                try self.add(price: request.newPrice, item: item) { (item) in
//                    
//                    try self.update(item, next: { (item) in
//                        completion(.success(IAddItemPriceUseCaseResponse.init(item: item)))
//                    })
//                    
//                }
//            })
//            
//        } catch ICRUDTemplateUseCaseError.notFound {
//            completion(.failure(.itemNotFound))
//        } catch ICRUDTemplateUseCaseError.errorOnOperaration {
//            completion(.failure(.unknownError))
//        } catch let error {
//            
//            guard let error = error as? IAddItemPriceUseCaseError else {
//                completion(.failure(.unknownError))
//                return
//            }
//            
//            completion(.failure(error))
//        }
//        
//    }
//    
//    private func add(price: Double, item: Item, next: @escaping (Item) throws ->()) throws {
//        item.prices.append(self.getNewPrice(price: price))
//        try next(item)
//    }
//    
//    private func getNewPrice(price: Double) -> ItemPrice {
//        return ItemPrice(price: price,
//                         location: Location(latitude: 0, longitude: 0),
//                         timeStamp: Date())
//    }
//    
//}
