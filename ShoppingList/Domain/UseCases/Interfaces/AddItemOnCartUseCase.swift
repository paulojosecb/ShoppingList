//
//  AddItemOnCart.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct AddItemOnCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
    let quantity: Int
}

enum AddItemOnCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol AddItemOnCartUseCase {
    func execute(request: AddItemOnCartUseCaseRequest, completion: @escaping (Result<List, AddItemOnCartUseCaseError>) -> Void)
}
