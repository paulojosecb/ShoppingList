//
//  DeleteListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct DeleteListUseCaseRequest {
    let uid: UUID
}

enum DeleteListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol DeleteListUseCase {
    func execute(request: DeleteListUseCaseRequest, completion: @escaping (Result<Bool, DeleteListUseCaseError>) -> Void)
}
