//
//  AddItemPriceUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 25/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class AddItemPriceUseCaseTest: XCTestCase {

    var repository: MockItemRepository? = nil
    let item = Item(name: "Item", initialPrice: nil)

    override func setUp() {
        repository = MockItemRepository()
        repository?.items = [item]
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func testAddPriceOnItem() {
        let expectation = XCTestExpectation(description: "Add price on Item")
        let useCase = AddItemPriceUseCase(repository: repository!)
        
        useCase.execute(request: .init(itemUUID: item.uuid,
                                       newPrice: 0.20,
                                       location: nil))
            .then { (response) in
                XCTAssertTrue(response.item.prices.count == 1)
                XCTAssertTrue(response.item.prices.first!.price == 0.20)
                
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testAddPriceOnItemWithInvalidItem() {
        let expectation = XCTestExpectation(description: "Add price on Invalid Item")
        let useCase = AddItemPriceUseCase(repository: repository!)
        
        useCase.execute(request: .init(itemUUID: "olá",
                                       newPrice: 0.20,
                                       location: nil))
            .then { (response) in
                XCTFail()
            }
            .catch { error in
                if let error = error as? IAddItemPriceUseCaseError,
                   error == .itemNotFound {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
        
        wait(for: [expectation], timeout: 2)
    }

}
