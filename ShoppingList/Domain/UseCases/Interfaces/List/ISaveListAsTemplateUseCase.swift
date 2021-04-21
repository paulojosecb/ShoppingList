//
//  CopyListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation

struct ISaveListAsTemplateUseCaseRequest {
    let uuid: UUID
}

struct ISaveListAsTemplateUseCaseResponse {
    let copyed: Bool
}

enum ISaveListAsTemplateUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol ISaveListAsTemplateUseCase {
    func execute(request: ISaveListAsTemplateUseCaseRequest, completion: @escaping (Result<ISaveListAsTemplateUseCaseResponse, ISaveListAsTemplateUseCaseError>) -> Void)
}
