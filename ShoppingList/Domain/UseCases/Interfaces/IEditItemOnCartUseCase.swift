//
//  EditItemOnCartUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IEditItemOnCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
    let quantity: Int
}

struct IEditItemOnCartUseCaseResponse {
    let list: List
}

enum IEditItemOnCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case invalidQuantity
    case unknownError
}

protocol IEditItemOnCartUseCase {
    func execute(request: IEditItemOnCartUseCaseRequest, completion: @escaping (Result<IEditItemOnCartUseCaseResponse, IEditItemOnCartUseCaseError>) -> Void)
}
