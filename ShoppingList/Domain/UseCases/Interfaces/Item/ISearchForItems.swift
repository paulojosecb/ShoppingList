//
//  ISearchForItems.swift
//  ShoppingList
//
//  Created by Paulo José on 20/05/21.
//

import Foundation
import Promises

struct ISearchForItemRequest {
    let query: String
}

struct ISearchForItemResponse {
    let item: [Item]
}

enum ISearchForItemError: Error {
    case itemNotFound
    case unknownError
}

protocol ISearchForItem {
    func execute(request: ISearchForItemRequest) -> Promise<ISearchForItemResponse>
}
