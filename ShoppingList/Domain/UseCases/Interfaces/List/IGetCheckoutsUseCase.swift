//
//  IGetCheckoutsUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises

struct IGetCheckoutsUseCaseRequest {
    let uuid: String?
}

struct IGetCheckoutsUseCaseResponse {
    let checkouts: [Checkout]
}

enum IGetCheckoutsUseCaseError: Error {
    case checkoutNotFound
    case unknownError
}

protocol IGetCheckoutsUseCase {
    func execute(request: IGetCheckoutsUseCaseRequest) -> Promise<IGetCheckoutsUseCaseResponse>
}
