//
//  DeleteListUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 21/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class DeleteListUseCaseTest: XCTestCase {
    
    var mockRepository: MockRepository? = nil
    
    class MockRepository: ICRUDRepository {
                
        var errorMock = false
        var lists: [List] = []
        
        func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
            return Promise { fullfill, reject in
                guard let list = (self.lists.first { $0.uuid == uuid}) as? T  else {
                    reject(ICRUDRepositoryError.notFound)
                    return
                }
                
                fullfill(list)
            }
        }
        
        func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
            return Promise { fullfill, reject in
                fatalError()
            }
        }
        
        func fetch<T>() -> Promise<[T]> where T : Fetchable {
            return Promise {fulfill, reject in
                fatalError()
            }
        }
        
        func create<T: Fetchable>(_ item: T) -> Promise<T> {
            return Promise { fullfill, reject in
                
                if (self.errorMock) {
                    reject(ICRUDRepositoryError.errorOnOperaration)
                    return
                }
                
                self.lists.append(item as! List)
                fullfill(item)
            }
        }
        
        func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
            return Promise { fullfill, reject in
                self.lists.append(item as! List)
                fullfill(item)
            }
        }
        
        func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
            return Promise { fullfill, reject in
                
                if !(self.lists.contains { $0.uuid == item.uuid }) {
                    reject(ICRUDRepositoryError.notFound)
                    return
                }
                
                self.lists = self.lists.filter { $0.uuid != item.uuid }
                fullfill(true)
            }
        }

    }
    
    override func setUp() {
        mockRepository = MockRepository()
        mockRepository?.lists = [List("My list")]
    }
    
    override func tearDown() {
        mockRepository = nil
    }
    
    func testDeleteListThatExists() {
        let expectation = XCTestExpectation(description: "Delete list that exists")
        let useCase = DeleteListUseCase(repository: mockRepository!)
        
        let list = mockRepository?.lists.first
        
        useCase.execute(request: .init(uuid: list!.uuid)).then { (response) in
            XCTAssertTrue(response.deleted)
            XCTAssertTrue(self.mockRepository!.lists.isEmpty)
            
            expectation.fulfill()
        }.catch { _ in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testDeleteListThatDoesNotExists() {
        let expectation = XCTestExpectation(description: "Delete list that does not exists")
        let useCase = DeleteListUseCase(repository: mockRepository!)
        
        let list = mockRepository?.lists.first
        
        useCase.execute(request: .init(uuid: UUID().uuidString)).then { (response) in
            XCTFail()
        }.catch { error in
            
            if let error = error as? IDeleteListUseCaseError,
               error == IDeleteListUseCaseError.listNotFound {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 2)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
