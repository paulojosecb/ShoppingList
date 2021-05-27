//
//  CopyListUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 19/02/21.
//

import Foundation
import Promises

struct ISaveListAsTemplateUseCaseRequest {
    let uuid: String
}

struct ISaveListAsTemplateUseCaseResponse {
    let copyed: Bool
    let templateList: List
}

enum ISaveListAsTemplateUseCaseError: Error {
    case listNotFound
    case unknownError
}

protocol ISaveListAsTemplateUseCase {
    func execute(request: ISaveListAsTemplateUseCaseRequest) -> ISaveListAsTemplateUseCaseResponse
}
