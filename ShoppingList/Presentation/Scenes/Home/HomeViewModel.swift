//
//  HomeViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import Foundation
import Promises

class HomeViewModel {
    
    let createListUseCase: CreateListUseCase
    
    init() {
        let coreDataStack = CoreDataStack()
        let repository = ListRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        self.createListUseCase = CreateListUseCase(repository: repository)
    }
    
    public func createListWith(name: String) -> Promise<List> {
        return Promise<List> { fulfull, reject in
            self.createListUseCase.execute(request: .init(name: name)).then { (response)in
                fulfull(response.list)
            }.catch { (error) in
                guard let error = error as? ICreateListUseCaseError else {
                    reject(ICreateListUseCaseError.unknownError)
                    return
                }
                reject(error)
            }
        }
    }
}
