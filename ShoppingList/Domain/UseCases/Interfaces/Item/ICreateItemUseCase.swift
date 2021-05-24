//
//  ICreateItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 24/05/21.
//

import Foundation
import Promises

struct ICreateItemUseCaseRequest {
    let item: Item
}

struct ICreateItemUseCaseResponse {
    let item: Item
}

enum ICreateItemUseCaseError: Error {
    case invalidName
    case priceInvalid
    case unknownError
}

protocol ICreateItemUseCase {
    func execute(request: ICreateItemUseCaseRequest) -> Promise<ICreateItemUseCaseResponse>
}
