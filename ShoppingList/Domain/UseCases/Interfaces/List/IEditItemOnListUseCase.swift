//
//  EditItemOnList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IEditItemOnListUseCaseRequest {
    let itemOnListUUID: String
    let listUUID: String
    let itemUUID: String
    let newQuantity: Int
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
    func execute(request: IEditItemOnListUseCaseRequest) -> Promise<IEditListNameUseCaseResponse>
}
