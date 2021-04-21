//
//  RemoveItemFromCart.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IRemoveItemFromCartUseCaseRequest {
    let cartUID: UUID
    let itemUID: UUID
}

struct IRemoveItemFromCartUseCaseResponse {
    let list: List
}

enum IRemoveItemFromCartUseCaseError: Error {
    case cartNotFound
    case itemNotFound
    case itemNotOnCart
    case unknownError
}

protocol IRemoveItemFromCartUseCase {
    func execute(request: IRemoveItemFromCartUseCaseRequest, completion: @escaping (Result<IRemoveItemFromCartUseCaseResponse, IRemoveItemFromCartUseCaseError>) -> Void)
}
