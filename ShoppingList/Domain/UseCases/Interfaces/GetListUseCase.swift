//
//  visualizeList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct GetListUseCaseRequest {
    let uid: UUID
}

enum GetListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol GetListUseCase {
    func execute(request: GetListUseCaseRequest, completion: @escaping (Result<List, GetListUseCaseError>) -> Void)
}

