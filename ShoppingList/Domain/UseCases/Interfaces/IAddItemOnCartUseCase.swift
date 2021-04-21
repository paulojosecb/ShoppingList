//
//  AddItemOnCart.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IAddItemOnCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
    let quantity: Int
}

struct IAddItemOnCartUseCaseResponse {
    let list: List
}

enum IAddItemOnCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol IAddItemOnCartUseCase {
    func execute(request: IAddItemOnCartUseCaseRequest, completion: @escaping (Result<IAddItemOnCartUseCaseResponse, IAddItemOnCartUseCaseError>) -> Void)
}
