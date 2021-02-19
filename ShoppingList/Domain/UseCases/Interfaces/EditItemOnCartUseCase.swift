//
//  EditItemOnCartUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct EditItemOnCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
    let quantity: Int
}

enum EditItemOnCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol EditItemOnCartUseCase {
    func execute(request: EditItemOnCartUseCaseRequest, completion: @escaping (Result<List, EditItemOnCartUseCaseError>) -> Void)
}
