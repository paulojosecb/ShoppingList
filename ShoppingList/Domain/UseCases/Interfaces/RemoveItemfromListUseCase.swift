//
//  RemoveItemfromList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct RemoveItemFromListUseCaseRequest {
    let listUID: UUID
    let itemUID: UUID
}

enum RemoveItemFromListUseCaseError: Error {
    case listNotFound
    case itemNotFound
    case itemNotOnList
    case unknownError
}

protocol RemoveItemFromListUseCase {
    func execute(request: RemoveItemFromListUseCaseRequest, completion: @escaping (Result<List, RemoveItemFromListUseCaseError>) -> Void)
}
