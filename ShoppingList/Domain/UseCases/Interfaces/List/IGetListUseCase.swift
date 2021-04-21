//
//  visualizeList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IGetListUseCaseRequest {
    let uuid: UUID
}

struct IGetListUseCaseResponse {
    let list: List
}

enum IGetListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol IGetListUseCase {
    func execute(request: IGetListUseCaseRequest, completion: @escaping (Result<IGetListUseCaseResponse, IGetListUseCaseError>) -> Void)
}

