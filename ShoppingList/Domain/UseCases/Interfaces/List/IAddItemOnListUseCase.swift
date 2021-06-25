//
//  AddItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IAddItemOnListUseCaseRequest {
    let listUUID: String
    let item: Item
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
    case itemAlreadyOnList
}

protocol IAddItemOnListUseCase {
    func execute(request: IAddItemOnListUseCaseRequest) -> Promise<IAddItemOnListUseCaseResponse>
}
