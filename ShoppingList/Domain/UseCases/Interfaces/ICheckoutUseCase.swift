//
//  CheckoutUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct ICheckoutUseCaseRequest {
    let listUID: UUID
}

struct ICheckoutUseCaseResponse {
    let list: List
}

enum ICheckoutUseCaseRequestError: Error {
    case listNotFound
    case unknownError
}

protocol ICheckoutUseCase {
    func execute(request: ICheckoutUseCaseRequest, completion: @escaping (Result<ICheckoutUseCaseResponse, ICheckoutUseCaseRequestError>) -> Void)
}
