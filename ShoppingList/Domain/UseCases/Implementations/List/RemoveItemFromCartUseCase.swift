import Foundation
import Promises

class RemoveItemFromCartUseCase: IRemoveItemFromCartUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
    }
    
    func execute(request: IRemoveItemFromCartUseCaseRequest, completion: @escaping (Result<IRemoveItemFromCartUseCaseResponse, IRemoveItemFromCartUseCaseError>) -> Void) {
        
        do {
            
            try self.fetch(uuid: request.listUUID) { (list: List) in
                
                try self.removeFromCart(item: request.itemUUID, on: list, next: { (list) in
                    
                    try self.update(list, next: { (list) in
                        completion(.success(.init(list: list)))
                    })
                    
                })
                
            }
            
        } catch ICRUDTemplateUseCaseError.notFound {
            completion(.failure(.itemNotFound))
        } catch ICRUDTemplateUseCaseError.errorOnOperaration {
            completion(.failure(.unknownError))
        } catch let error {
            
            guard let error = error as? IRemoveItemFromCartUseCaseError else {
                completion(.failure(.unknownError))
                return
            }
            
            completion(.failure(error))
            
        }

        
    }
    
    private func removeFromCart(item: UUID, on list: List, next: @escaping (List) throws -> Void) throws {
        
        if (list is Cart) {
            throw IAddItemOnCartUseCaseError.listNotFound
        }
        
        let itemOnList = list.cart.items.first { $0.item.uuid == item}
        
        guard let itemL = itemOnList else {
            throw IAddItemOnCartUseCaseError.itemNotInList
        }
        
        list.cart.items.removeAll { $0.uuid == itemL.uuid }
        
        list.items.append(itemL)
        
        try next(list)
    }
    

    func execute(request: IRemoveItemFromCartUseCaseRequest) -> Promise<IRemoveItemFromCartUseCaseResponse> {
        return Promise { fulfill, reject in
            
            self.repository.fetch(uuid: request.listUUID).then { (list: List) in
                
                do {
                    try list.moveItemOutOfCart(itemUUID: request.itemUUID)
                } catch let error {
                    reject(self.handle(error))
                }
       
                self.repository.update(list).then { (list: List)in
                    fulfill(.init(list: list))
                }.catch { (error) in
                    reject(self.handle(error))
                }

            }.catch { (error) in
                reject(self.handle(error))
            }
            
        }
    }
    
    private func handle(_ error: Error) -> ICreateListUseCaseError {
        guard let error = error as? ICRUDRepositoryError else {
            return .unknownError
        }
        
        switch error {
        case .errorOnOperaration:
            return .unknownError
        default:
            return .unknownError
        }
    }
    
}
