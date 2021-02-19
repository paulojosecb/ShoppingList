//
//  AddItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct AddItemOnListUseCaseRequest {
    let listUID: UUID
    let itemUID: UUID
    let quantity: Int
}

enum AddItemOnListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol AddItemOnListUseCase {
    func execute(request: AddItemOnListUseCaseRequest, completion: @escaping (Result<List, AddItemOnListUseCaseError>) -> Void)
}
