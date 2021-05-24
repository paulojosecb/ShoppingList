//
//  CreateItemUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 24/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class CreateItemUseCaseTest: XCTestCase {
    
    var mockRepository: MockItemRepository? = nil

    
    override func setUp() {
        mockRepository = MockItemRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
    }
    
    func testCreateItemHappyPath() {
        let expectation = XCTestExpectation(description: "Create item")
        let useCase = CreateItemUseCase(repository: mockRepository!)
        
        let item = Item(name: "Item 1", initialPrice: nil)
        
        useCase.execute(request: .init(item: item))
            .then { (response) in
                if (response.item.uuid == item.uuid) {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            }.catch { (_) in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testCreateItemWithInvalidName() {
        let expectation = XCTestExpectation(description: "Create item")
        let useCase = CreateItemUseCase(repository: mockRepository!)
        
        let item = Item(name: "", initialPrice: nil)
        
        useCase.execute(request: .init(item: item))
            .then { (response) in
                XCTFail()
            }.catch { (error) in
                if let err = error as? ICreateItemUseCaseError,
                   err == .invalidName {
                    XCTAssert(true)
                    expectation.fulfill()
                }
            }
        
        wait(for: [expectation], timeout: 2)
    }


}
