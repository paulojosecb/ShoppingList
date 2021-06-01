//
//  DeleteListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct IDeleteListUseCaseRequest {
    let uuid: String
}

struct IDeleteListUseCaseResponse {
    let deleted: Bool
}

enum IDeleteListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol IDeleteListUseCase {
    func execute(request: IDeleteListUseCaseRequest) -> Promise<IDeleteListUseCaseResponse>
}
