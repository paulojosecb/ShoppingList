//
//  EditItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IEditItemOnListUseCaseRequest {
    let listUID: UUID
    let itemUID: UUID
    let quantity: Int
}

struct IEditItemOnListUseCaseResponse {
    let list: List
}

enum IEditItemOnListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol IEditItemOnListUseCase {
    func execute(request: IEditItemOnListUseCaseRequest, completion: @escaping (Result<IEditItemOnListUseCaseResponse, IEditItemOnListUseCaseError>) -> Void)
}
