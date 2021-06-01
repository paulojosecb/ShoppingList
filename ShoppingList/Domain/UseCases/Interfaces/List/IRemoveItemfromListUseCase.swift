//
//  RemoveItemfromList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IRemoveItemFromListUseCaseRequest {
    let listUUID: String
    let itemUUID: String
}

struct IRemoveItemFromListUseCaseResponse {
    let list: List
}

enum IRemoveItemFromListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case itemNotOnList
    case unknownError
}

protocol IRemoveItemFromListUseCase {
    func execute(request: IRemoveItemFromListUseCaseRequest) -> Promise<IRemoveItemFromListUseCaseResponse>
}
