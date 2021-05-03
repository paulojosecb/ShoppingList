//
//  FetchRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation
import Promises

enum ICRUDRepositoryError: Error {
    case notFound
    case errorOnOperaration
}

typealias ICRUDRepositoryResult<T: Fetchable> = Result<T, ICRUDRepositoryError>
typealias ICRUDRepositoryResultBool = Result<Bool, ICRUDRepositoryError>

protocol ICRUDRepository {
    func fetch<T: Fetchable>(uuid: UUID) -> Promise<T>
    func create<T: Fetchable>(_ item: T) -> Promise<T>
    func update<T: Fetchable>(_ item: T, completion: @escaping(ICRUDRepositoryResult<T>) throws -> Void)
    func delete<T: Fetchable>(_ item: T, completion: @escaping(ICRUDRepositoryResultBool) throws -> Void)
}
