//
//  EditListNameUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 26/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class EditListNameUseCaseTest: XCTestCase {
    
    var repository: MockListRepository? = nil
    
    override func setUp() {
        repository = MockListRepository()
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func testEditListName() {
        let expectation = XCTestExpectation(description: "Edit list name")
        let useCase = EditListNameUseCase(repository: repository!)
        
        useCase.execute(request: .init(name: "New name", uuid: repository!.list.first!.uuid))
            .then { response in
                XCTAssertTrue(response.list.name == "New name")
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testEditNameWithInvalidName() {
        let expectation = XCTestExpectation(description: "Edit list name with invalid Name")
        let useCase = EditListNameUseCase(repository: repository!)
        
        useCase.execute(request: .init(name: "", uuid: repository!.list.first!.uuid))
            .then { response in
                XCTFail()
            }
            .catch { error in
                if let error = error as? IEditListNameUseCaseError,
                   error == .invalidName {
                    XCTAssertTrue(true)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testEditNameOfListThatDoesNotExists() {
        let expectation = XCTestExpectation(description: "Edit list name of list that does not exists")
        let useCase = EditListNameUseCase(repository: repository!)
        
        useCase.execute(request: .init(name: "New name", uuid: "Olá"))
            .then { response in
                XCTFail()
            }
            .catch { error in
                if let error = error as? IEditListNameUseCaseError,
                   error == .listNotFound {
                    XCTAssertTrue(true)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        
        wait(for: [expectation], timeout: 2)
    }


}
