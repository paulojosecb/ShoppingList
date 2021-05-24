//
//  GetItemUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 24/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class GetItemUseCaseTest: XCTestCase {
    
    var repository: MockItemRepository? = nil
    
    let item = Item(name: "Item", initialPrice: nil)

    override func setUp() {
        repository = MockItemRepository()
        
        repository?.items = [item]
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func testGetItemUseCaseHappyPath() {
        let expectation = XCTestExpectation(description: "Get item by UUID")
        let useCase = GetItemUseCase(repository: repository!)
        
        useCase.execute(request: .init(uuid: item.uuid))
            .then { (response) in
                XCTAssertTrue(response.item.uuid == self.item.uuid)
                XCTAssertTrue(response.item.name == self.item.name)
                
                expectation.fulfill()
            }.catch { (_) in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetItemThatDoesNotExists() {
        let expectation = XCTestExpectation(description: "Get item that does not existis")
        let useCase = GetItemUseCase(repository: repository!)
        
        useCase.execute(request: .init(uuid: "invalidUUID"))
            .then { (response) in
                XCTFail()
            }.catch { (error) in
                if let err = error as? IGetItemUseCaseError,
                   err == .itemNotFound {
                    XCTAssert(true)
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        
        wait(for: [expectation], timeout: 2)
    }

}
