//
//  ISearchForItems.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation
import Promises

struct ISearchForItemsUseCaseRequest {
    let query: String
}

struct ISearchForItemsUseCaseResponse {
    let item: [Item]
}

enum ISearchForItemsUseCaseError: Error {
    case itemNotFound
    case unknownError
}

protocol ISearchForItemsUseCase {
    func execute(request: ISearchForItemsUseCaseRequest) -> Promise<ISearchForItemsUseCaseResponse>
}
