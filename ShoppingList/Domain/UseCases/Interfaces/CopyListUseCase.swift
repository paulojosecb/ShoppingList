//
//  CopyListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct CopyListUseCaseRequest {
    let uid: UUID
}

enum CopyListUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol CopyListUseCase {
    func execute(request: CopyListUseCaseRequest, completion: @escaping (Result<List, CopyListUseCaseError>) -> Void)
}
