//
//  visualizeList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IGetListUseCaseRequest {
    let uuid: String?
}

struct IGetListUseCaseResponse {
    let lists: [List]
}

enum IGetListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol IGetListUseCase {
    func execute(request: IGetListUseCaseRequest) -> Promise<IGetListUseCaseResponse>
}

