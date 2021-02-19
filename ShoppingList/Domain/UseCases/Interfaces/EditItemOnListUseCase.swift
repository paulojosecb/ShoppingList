//
//  EditItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct EditItemOnListUseCaseRequest {
    let listUID: UUID
    let itemUID: UUID
    let quantity: Int
}

enum EditItemOnListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol EditItemOnListUseCase {
    func execute(request: EditItemOnListUseCaseRequest, completion: @escaping (Result<List, EditItemOnListUseCaseError>) -> Void)
}
