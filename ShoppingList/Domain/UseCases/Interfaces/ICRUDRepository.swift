//
//  FetchRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

enum ICRUDRepositoryError: Error {
    case notFound
    case errorOnOperaration
}

typealias ICRUDRepositoryResult<T: Fetchable> = Result<T, ICRUDRepositoryError>
typealias ICRUDRepositoryResultBool = Result<Bool, ICRUDRepositoryError>

protocol ICRUDRepository {
    func fetch<T>(uuid: UUID, completion: @escaping(ICRUDRepositoryResult<T>) throws -> Void)
    func create<T: Fetchable>(_ item: T, completion: @escaping(ICRUDRepositoryResult<T>) throws -> Void)
    func update<T: Fetchable>(_ item: T, completion: @escaping(ICRUDRepositoryResult<T>) throws -> Void)
    func delete<T>(_ item: T, completion: @escaping(ICRUDRepositoryResultBool) throws -> Void)
}
