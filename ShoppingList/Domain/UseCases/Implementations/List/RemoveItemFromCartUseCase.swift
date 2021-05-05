import Foundation
import Promises

class RemoveItemFromCartUseCase: IRemoveItemFromCartUseCase {
    
    let repository: ICRUDRepository
    
    init(repository: ICRUDRepository) {
        self.repository = repository
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
