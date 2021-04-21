//
//  IEditListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

struct IEditListNameUseCaseRequest {
    let name: String
}

struct IEditListNameUseCaseResponse {
    let list: List
}

enum IEditListNameUseCaseError: Error {
    case invalidName
    case unknownError
}

protocol IEditListNameUseCase {
    func execute(request: IEditListNameUseCaseRequest, completion: @escaping (Result<IEditListNameUseCaseResponse, IEditListNameUseCaseError>) -> ())
}
