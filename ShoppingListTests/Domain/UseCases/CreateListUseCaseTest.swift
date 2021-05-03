//
//  CreateListUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 23/04/21.
//

import XCTest
import Promises
@testable import ShoppingList

class CreateListUseCaseTest: XCTestCase {
    
    var mockRepository: MockCreateListRepository? = nil
    
    class MockCreateListRepository: ICRUDRepository {
        
        var errorMock = false
        var list: [List] = []
        
        func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
            return Promise { fullfill, reject in
                guard let list = (self.list.first { $0.uuid == uuid}) as? T  else {
                    reject(ICRUDRepositoryError.notFound)
                    return
                }
                
                fullfill(list)
            }
        }
        
        func create<T: Fetchable>(_ item: T) -> Promise<T> {
            return Promise { fullfill, reject in
                
                if (self.errorMock) {
                    reject(ICRUDRepositoryError.errorOnOperaration)
                    return
                }
                
                self.list.append(item as! List)
                fullfill(item)
            }
        }
        
        func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
            return Promise { fullfill, reject in
                self.list.append(item as! List)
                fullfill(item)
            }
        }
        
        func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
            return Promise { fullfill, reject in
                self.list.append(item as! List)
                fullfill(true)
            }
        }

    }
    
    override func setUp() {
        mockRepository = MockCreateListRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateWithoutError() {
        let expectation = XCTestExpectation(description: "List with name")
        let createUseCase = CreateListUseCase(repository: mockRepository!)
        
        createUseCase.execute(request: .init(name: "Lista 1")).then { response in
            assert(response.list.name == "Lista 1")
            assert(response.list.items.isEmpty)
            expectation.fulfill()
        }
        .catch { error in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCreateWithInvalidName() {
        let expectation = XCTestExpectation(description: "CreateList with name invalidName")
        let createUseCase = CreateListUseCase(repository: mockRepository!)
        
        createUseCase.execute(request: .init(name: "")).then { response in
            XCTFail()
        }
        .catch { error in
            guard let error = error as? ICreateListUseCaseError else {
                XCTFail()
                return
            }
            
            if (error == ICreateListUseCaseError.invalidName) {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCreateWithError() {
        mockRepository?.errorMock = true
        let expectation = XCTestExpectation(description: "List with name")
        let createUseCase = CreateListUseCase(repository: mockRepository!)
        
        createUseCase.execute(request: .init(name: "Lista 1")).then { response in
            XCTFail()
        }
        .catch { error in
            guard let error = error as? ICreateListUseCaseError else {
                XCTFail()
                return
            }
            
            if (error == ICreateListUseCaseError.unknownError) {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }


}
