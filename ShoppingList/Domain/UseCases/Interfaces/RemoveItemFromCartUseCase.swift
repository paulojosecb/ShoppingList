//
//  RemoveItemFromCart.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct RemoveItemFromCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
}

enum RemoveItemFromCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case itemNotOnCart
    case unknownError
}

protocol RemoveItemFromCartUseCase {
    func execute(request: RemoveItemFromCartUseCaseRequest, completion: @escaping (Result<List, RemoveItemFromCartUseCaseError>) -> Void)
}
