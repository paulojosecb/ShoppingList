//
//  RemoveItemFromCart.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IRemoveItemFromCartUseCaseRequest {
    let listUUID: String
    let itemUUID: String
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
    func execute(request: IRemoveItemFromCartUseCaseRequest) -> Promise<IRemoveItemFromCartUseCaseResponse>
}
