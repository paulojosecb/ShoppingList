//
//  FetchRepository.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

enum IRepositoryError: Error {
    case notFound
    case errorOnOperaration
}

protocol IRepository {
    func fetch<T>(uuid: UUID, completion: @escaping(Result<T, IRepositoryError>) throws -> Void)
    func create<T>(_ item: T, completion: @escaping(Result<T, IRepositoryError>) throws -> Void)
    func update<T>(_ item: T, completion: @escaping(Result<T, IRepositoryError>) throws -> Void)
    func delete<T>(_ item: T, completion: @escaping(Result<Bool, IRepositoryError>) throws -> Void)
}
