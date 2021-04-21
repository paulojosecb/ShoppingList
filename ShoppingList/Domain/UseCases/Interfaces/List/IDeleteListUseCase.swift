//
//  DeleteListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct IDeleteListUseCaseRequest {
    let uid: UUID
}

struct IDeleteListUseCaseResponse {
    let deleted: Bool
}

enum IDeleteListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol IDeleteListUseCase {
    func execute(request: IDeleteListUseCaseRequest, completion: @escaping (Result<IDeleteListUseCaseResponse, IDeleteListUseCaseError>) -> Void)
}
