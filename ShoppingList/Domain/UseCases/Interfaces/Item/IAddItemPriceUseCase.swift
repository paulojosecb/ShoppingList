//
//  IAddItemPriceUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

struct IAddItemPriceUseCaseRequest {
    let itemUUID: UUID
    let newPrice: Double
    let location: Location
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
    func execute(request: IAddItemPriceUseCaseRequest, completion: @escaping (Result<IAddItemPriceUseCaseResponse, IAddItemPriceUseCaseError>) -> Void)
}
