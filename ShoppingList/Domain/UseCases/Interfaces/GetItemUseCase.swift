//
//  GetItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct GetItemUseCaseRequest {
    let uid: UUID
}

enum GetItemUseCaseError: Error {
    case itemNotFound
    case unknownError
}

protocol GetItemUseCase {
    func execute(request: GetItemUseCaseRequest, completion: @escaping (Result<Item, GetItemUseCaseError>) -> Void)
}
