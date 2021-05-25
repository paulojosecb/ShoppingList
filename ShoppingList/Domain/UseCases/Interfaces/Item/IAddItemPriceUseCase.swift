//
//  IAddItemPriceUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation
import Promises

struct IAddItemPriceUseCaseRequest {
    let itemUUID: String
    let newPrice: Double
    let location: Location?
}

struct IAddItemPriceUseCaseResponse {
    let item: Item
}

enum IAddItemPriceUseCaseError: Error {
    case itemNotFound
    case priceInvalid
    case unknownError
}

protocol IAddItemPriceUseCase {
    func execute(request: IAddItemPriceUseCaseRequest) -> Promise<IAddItemPriceUseCaseResponse>
}
