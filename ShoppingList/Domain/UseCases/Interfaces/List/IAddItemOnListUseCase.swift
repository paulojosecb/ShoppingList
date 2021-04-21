//
//  AddItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IAddItemOnListUseCaseRequest {
    let listUUID: UUID
    let itemUUID: UUID
    let quantity: Int
}

struct IAddItemOnListUseCaseResponse {
    let list: List
}

enum IAddItemOnListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol IAddItemOnListUseCase {
    func execute(request: IAddItemOnListUseCaseRequest, completion: @escaping (Result<IAddItemOnListUseCaseResponse, IAddItemOnListUseCaseError>) -> Void)
}
