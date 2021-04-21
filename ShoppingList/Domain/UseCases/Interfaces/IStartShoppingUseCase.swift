//
//  StartShoppingUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IStartShoppingUseCaseRequest {
    let listUID: UUID
}

struct IStartShoppingUseCaseResponse {
    let list: List
}

enum IStartShoppingUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol IStartShoppingUseCase {
    func execute(request: IStartShoppingUseCaseRequest, completion: @escaping (Result<IStartShoppingUseCaseResponse, IStartShoppingUseCaseError>) -> Void)
}
