//
//  TemplateUseCase.swift
//  ShoppingList
//
//  Created by Paulo José on 21/04/21.
//

import Foundation

enum ICRUDTemplateUseCaseError: Error {
    case notFound
    case errorOnOperaration
}

protocol ICRUDTemplateUseCase {
    
    var repository: ICRUDRepository { get set }
    
    func fetch<T: Fetchable>(uuid: UUID, next: @escaping (T) throws -> ()) throws
    func create<T: Fetchable>(_ item: T, next: @escaping (T) throws -> ()) throws
    func update<T: Fetchable>(_ item: T, next: @escaping (T) throws -> ()) throws
    func delete<T: Fetchable>(_ item: T, next: @escaping (Bool) throws -> ()) throws
    
}

extension ICRUDTemplateUseCase {
    
    func fetch<T: Fetchable>(uuid: UUID, next: @escaping (T) throws -> ()) throws {
        self.repository.fetch(uuid: uuid) { (result: ICRUDRepositoryResult<T>) in
            switch result {
            case .success(let item):
                try next(item)
            case .failure(let error):
                switch error {
                case .errorOnOperaration:
                    throw ICRUDTemplateUseCaseError.errorOnOperaration
                case .notFound:
                    throw ICRUDTemplateUseCaseError.notFound
                }
            }
        }
    }
    
    func create<T: Fetchable>(_ item: T, next: @escaping (T) throws -> ()) throws {
        self.repository.create(item) { (result: ICRUDRepositoryResult<T> ) in
            switch result {
            case .success(let item):
                try next(item)
            case .failure(let error):
                switch error {
                case .errorOnOperaration:
                    throw ICRUDTemplateUseCaseError.errorOnOperaration
                case .notFound:
                    throw ICRUDTemplateUseCaseError.notFound
                }
            }
        }
    }

    func update<T: Fetchable>(_ item: T, next: @escaping (T) throws -> ()) throws {
        self.repository.update(item) { (result: ICRUDRepositoryResult<T> ) in
            switch result {
            case .success(let item):
                try next(item)
            case .failure(let error):
                switch error {
                case .errorOnOperaration:
                    throw ICRUDTemplateUseCaseError.errorOnOperaration
                case .notFound:
                    throw ICRUDTemplateUseCaseError.notFound
                }
            }
        }
    }
    
    func delete<T: Fetchable>(_ item: T, next: @escaping (Bool) throws -> ()) throws {
        self.repository.delete(item) { (result: ICRUDRepositoryResultBool ) in
            switch result {
            case .success(_):
                try next(true)
            case .failure(let error):
                switch error {
                case .errorOnOperaration:
                    throw ICRUDTemplateUseCaseError.errorOnOperaration
                case .notFound:
                    throw ICRUDTemplateUseCaseError.notFound
                }
            }
        }
    }

}

