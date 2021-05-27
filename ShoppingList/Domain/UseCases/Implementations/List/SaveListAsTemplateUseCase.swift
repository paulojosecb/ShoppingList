//
//  SaveListAsTemplateUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 27/05/21.
//

import Foundation
import Promises

class SaveListAsTemplateUseCase: ISaveListAsTemplateUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: ISaveListAsTemplateUseCaseRequest) -> Promise<ISaveListAsTemplateUseCaseResponse> {
    
        return Promise<ISaveListAsTemplateUseCaseResponse> { fulfill, reject in
            
            self.repository.fetch(uuid: request.uuid)
                .then { (list: List) -> Promise<List> in
                    let template = List.makeTemplateCopy(list: list)
                    return self.repository.create(template)
                }
                .then { list in
                    fulfill(.init(copyed: true, templateList: list))
                }
                .catch { _ in
                    reject(ISaveListAsTemplateUseCaseError.listNotFound)
                }
        
        }
        
    }
    
    
}
