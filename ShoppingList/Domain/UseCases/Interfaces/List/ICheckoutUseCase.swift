//
//  CheckoutUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct ICheckoutUseCaseRequest {
    let listUUID: String
}

struct ICheckoutUseCaseResponse {
    let list: List
}

enum ICheckoutUseCaseRequestError: Error {
    case listNotFound
    case cartEmpty
    case unknownError
}

protocol ICheckoutUseCase {
    func execute(request: ICheckoutUseCaseRequest) -> Promise<ICheckoutUseCaseResponse>
}
