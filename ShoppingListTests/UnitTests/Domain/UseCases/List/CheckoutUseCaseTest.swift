//
//  CheckoutUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 27/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class CheckoutUseCaseTest: XCTestCase {
    
    var listRepository: MockListRepository? = nil
    var checkoutRepository: MockCheckoutRepository? = nil
    
    override func setUp() {
        listRepository = MockListRepository()
        checkoutRepository = MockCheckoutRepository()
    }
    
    override func tearDown() {
        listRepository = nil
        checkoutRepository = nil
    }

    func testCheckoutList() {
        let expectation = XCTestExpectation(description: "Checkout list")
        let useCase = CheckoutUseCase(listRepository: listRepository!,
                                      checkoutRepository: checkoutRepository!)
        
        useCase.execute(request: .init(listUUID: listRepository!.list.first!.uuid,
                                       date: Date(),
                                       location: nil))
            .then { response in
                XCTAssertTrue(response.checkout.listUUID == self.listRepository!.list.first!.uuid)
                XCTAssertTrue(response.checkout.items.count == self.listRepository!.list.first?.getItemsFromList().count)
                XCTAssertTrue(response.checkout.total == self.listRepository!.list.first!.total)
                
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }

}
