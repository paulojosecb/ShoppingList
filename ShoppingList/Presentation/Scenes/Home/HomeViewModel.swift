//
//  HomeViewModel.swift
//  ShoppingList
//
//  Created by Paulo José on 07/05/21.
//

import Foundation
import Promises

class HomeViewModel: IHomeViewModel {
    
    private let createListUseCase: ICreateListUseCase
    private let getListsUseCase: IGetListUseCase
    
    var lists: [List] = [
    ]
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        
        let repository = ListRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
        
        self.createListUseCase = CreateListUseCase(repository: repository)
        self.getListsUseCase = GetListUseCase(repository: repository)
    }
    
    public func fetchLists() -> Promise<[List]> {
        return Promise { fulfill, reject in
            fulfill(self.lists)
//            self.getListsUseCase.execute(request: .init(uuid: nil))
//                .then { response in
//                    fulfill(response.lists)
//                }
//                .catch { _ in
//                    reject(IGetItemUseCaseError.unknownError)
//                }
        }
    }
    
    public func createListWith(name: String) -> Promise<List> {
        return Promise<List> { fulfill, reject in
            let list = List(name)
            self.lists.append(list)
            fulfill(list)
//            self.createListUseCase.execute(request: .init(name: name)).then { (response)in
//                fulfull(response.list)
//            }.catch { (error) in
//                guard let error = error as? ICreateListUseCaseError else {
//                    reject(ICreateListUseCaseError.unknownError)
//                    return
//                }
//                reject(error)
//            }
//        }
        }
    }
}
