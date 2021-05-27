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
    let date: Date
    let location: Location?
}

struct ICheckoutUseCaseResponse {
    let checkout: Checkout
}

enum ICheckoutUseCaseError: Error {
    case listNotFound
    case cartEmpty
    case unknownError
}

protocol ICheckoutUseCase {
    func execute(request: ICheckoutUseCaseRequest) -> Promise<ICheckoutUseCaseResponse>
}
