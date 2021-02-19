//
//  CreateList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct CreateListUseCaseRequest {
    let name: String
}

enum CreateListUseCaseError {
    case invalidName
    case unknownError
}

protocol CreateListUseCase {
    func execute(request: CreateListUseCaseRequest, completion: @escaping (Result<List, CreateListUseCaseError>) -> ())
}
