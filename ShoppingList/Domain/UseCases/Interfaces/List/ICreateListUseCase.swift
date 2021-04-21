//
//  CreateList.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct ICreateListUseCaseRequest {
    let name: String
}

struct ICreateListUseCaseResponse {
    let list: List
}

enum ICreateListUseCaseError: Error {
    case invalidName
    case unknownError
}

protocol ICreateListUseCase {
    func execute(request: ICreateListUseCaseRequest, completion: @escaping (Result<ICreateListUseCaseResponse, ICreateListUseCaseError>) -> ())
}
