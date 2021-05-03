////
////  AddItemOnCartUseCase.swift
////  ShoppingList
////
////  Created by Paulo José on 21/04/21.
////
//
//import Foundation
//
//class AddItemOnCartUseCase: IAddItemOnCartUseCase {
//    var repository: ICRUDRepository
//
//    init(repository: ICRUDRepository) {
//        self.repository = repository
//    }
//    
////    func execute(request: IAddItemOnCartUseCaseRequest, completion: @escaping (Result<IAddItemOnCartUseCaseResponse, IAddItemOnCartUseCaseError>) -> Void) {
////
////        do {
////
////            try self.fetch(uuid: request.listUUID) { (list: List) in
////
////                try self.addToCart(item: request.itemUUID,
////                                   on: list,
////                                   next: { (list: List) in
////
////                    try self.update(list,
////                                    next: { (list) in
////                        completion(.success(.init(list: list)))
////                    })
////
////                })
////
////            }
////
////        } catch ICRUDTemplateUseCaseError.notFound {
////            completion(.failure(.itemNotFound))
////        } catch ICRUDTemplateUseCaseError.errorOnOperaration {
////            completion(.failure(.unknownError))
////        } catch let error {
////
////            guard let error = error as? IAddItemOnCartUseCaseError else {
////                completion(.failure(.unknownError))
////                return
////            }
////
////            completion(.failure(error))
////
////        }
////
////    }
////
////    private func addToCart(item: UUID, on list: List, next: @escaping (List) throws -> Void) throws {
////
////        if (list is Cart) {
////            throw IAddItemOnCartUseCaseError.listNotFound
////        }
////
////        let itemOnList = list.items.first { $0.item.uuid == item}
////
////        guard let itemL = itemOnList else {
////            throw IAddItemOnCartUseCaseError.itemNotInList
////        }
////
////        list.items.removeAll { $0.uuid == itemL.uuid }
////
////        list.cart.items.append(itemL)
////
////        try next(list)
////    }
//
//}
