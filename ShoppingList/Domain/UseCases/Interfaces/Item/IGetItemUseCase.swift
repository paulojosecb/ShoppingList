//
//  GetItemUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IGetItemUseCaseRequest {
    let uid: UUID
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
    func execute(request: IGetItemUseCaseRequest, completion: @escaping (Result<IGetItemUseCaseResponse, IGetItemUseCaseError>) -> Void)
}
