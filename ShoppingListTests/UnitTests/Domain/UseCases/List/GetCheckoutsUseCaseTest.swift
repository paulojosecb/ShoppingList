//
//  GetCheckoutsUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 28/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class GetCheckoutsUseCaseTest: XCTestCase {
    
    var repository: MockCheckoutRepository? = nil
    
    override func setUp() {
        repository = MockCheckoutRepository()
    }
    
    override func tearDown() {
        self.repository = nil
    }
    
    func testGetAllCheckouts() {
//        let expectation = XCTestExpectation(description: "Get all checkouts")
//        let useCase = GetCheckoutsUseCase(repository: repository!)
//        
//        useCase.execute(request: .init(uuid: nil))
//            .then { response in
//                XCTAssertTrue(response.checkouts.count == self.repository!.checkouts.count)
//                
//                expectation.fulfill()
//            }
//            .then { _ in
//                XCTFail()
//            }
//        
//        wait(for: [expectation], timeout: 2)
//    }
//    
//    func testGetOneCheckout() {
//        let expectation = XCTestExpectation(description: "Get one checkouts")
//        let useCase = GetCheckoutsUseCase(repository: repository!)
//
//        useCase.execute(request: .init(uuid: repository!.checkouts.first!.uuid))
//            .then { response in
//                XCTAssertTrue(response.checkouts.first!.uuid == self.repository!.checkouts.first!.uuid)
//
//                expectation.fulfill()
//            }
//            .then { _ in
//                XCTFail()
//            }
//
//        wait(for: [expectation], timeout: 2)
//    }

}
