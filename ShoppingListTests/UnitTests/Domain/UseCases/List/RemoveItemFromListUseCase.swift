//
//  RemoveItemFromListUseCase.swift
//  ShoppingListTests
//
//  Created by Paulo José on 26/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class RemoveItemFromListUseCaseTest: XCTestCase {
    
    var repository: MockListRepository? = nil
    
    override func setUp() {
        repository = MockListRepository()
        try! repository?.list.first?.addItemToList(ItemOnList(item: "itemUUID",
                                                         on: repository!.list.first!.uuid,
                                                         quantity: 1,
                                                         unitPrice: nil,
                                                         uuid: name))
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func testRemoveItem() {
        let expectaction = XCTestExpectation(description: "Remove item from list")
        let useCase = RemoveItemFromListUseCase(listRepository: repository!)
        
        useCase.execute(request: .init(listUUID: repository!.list.first!.uuid,
                                       itemUUID: "itemUUID"))
            .then { response in
                let containsItem = response.list.getItemsFromList().contains { $0.itemUUID == "itemUUID"}
                XCTAssertTrue(!containsItem)
                expectaction.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectaction], timeout: 2)
    }
    
    func testRemoveItemThatDoesNotExists() {
        let expectaction = XCTestExpectation(description: "Remove item from list that does not exists")
        let useCase = RemoveItemFromListUseCase(listRepository: repository!)
        
        useCase.execute(request: .init(listUUID: repository!.list.first!.uuid,
                                       itemUUID: "itemUUID2"))
            .then { response in
                XCTFail()
            }
            .catch { error in
                if let error = error as? IRemoveItemFromListUseCaseError {
                    expectaction.fulfill()
                } else {
                    XCTFail()
                }
            }
        
        wait(for: [expectaction], timeout: 2)
    }



}
