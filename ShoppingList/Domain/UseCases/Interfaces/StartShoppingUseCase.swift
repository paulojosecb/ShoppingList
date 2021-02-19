//
//  StartShoppingUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct StartShoppingUseCaseRequest {
    let listUID: UUID
}

enum StartShoppingUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol StartShoppingUseCase {
    func execute(request: StartShoppingUseCaseRequest, completion: @escaping (Result<List, StartShoppingUseCaseError>) -> Void)
}
