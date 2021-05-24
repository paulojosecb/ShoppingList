//
//  GetItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IGetItemUseCaseRequest {
    let uuid: UUID
}

struct IGetItemUseCaseResponse {
    let item: Item
}

enum IGetItemUseCaseError: Error {
    case itemNotFound
    case invalidUUID
    case unknownError
}

protocol IGetItemUseCase {
    func execute(request: IGetItemUseCaseRequest) -> Promise<IGetItemUseCaseResponse>
}
