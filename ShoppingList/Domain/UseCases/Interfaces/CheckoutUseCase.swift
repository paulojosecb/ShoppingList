//
//  CheckoutUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct CheckoutUseCaseRequest {
    let listUID: UUID
}

enum CheckoutUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol CheckoutUseCase {
    func execute(request: CheckoutUseCaseRequest, completion: @escaping (Result<List, CheckoutUseCaseError>) -> Void)
}
