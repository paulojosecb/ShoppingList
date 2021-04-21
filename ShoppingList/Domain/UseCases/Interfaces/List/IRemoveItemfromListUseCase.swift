//
//  RemoveItemfromList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IRemoveItemFromListUseCaseRequest {
    let listUID: UUID
    let itemUID: UUID
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
    func execute(request: IRemoveItemFromListUseCaseRequest, completion: @escaping (Result<IRemoveItemFromListUseCaseResponse, IRemoveItemFromListUseCaseError>) -> Void)
}
