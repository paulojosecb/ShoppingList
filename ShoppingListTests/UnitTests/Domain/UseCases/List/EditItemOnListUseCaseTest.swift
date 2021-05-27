//
//  EditItemOnListUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 21/05/21.
//

import XCTest
import Promises
@testable import ShoppingList


class EditItemOnListUseCaseTest: XCTestCase {
    
    var mockListRepository: MockListRepository? = nil
    var mockItemOnListRepository: MockItemOnListRepository? = nil
    
    var itemOnList: ItemOnList? = nil

    override func setUp() {
        mockListRepository = MockListRepository()
        mockItemOnListRepository = MockItemOnListRepository()
                
        mockItemOnListRepository?.items = [
            ItemOnList(item: "myItemID",
                       on: "myListID",
                       quantity: 1, unitPrice: nil,
                                        uuid: "myItemOnListID")
        ]
                
        mockListRepository?.list = [
            List(uuid: "myListID",
                 name: "List 1",
                 items: [self.mockItemOnListRepository!.items.first!], cart: Cart(listUUID: "myListID"))
        ]
    }
    
    override func tearDown() {
        mockListRepository = nil
    }
    
    func testEditItemOnList() {
        let expectation = XCTestExpectation(description: "Edit item on list")
        let useCase = EditItemOnListUseCase(itemOnListRepository: mockItemOnListRepository! as ICRUDRepository,
                                            listRepository: mockListRepository! as ICRUDRepository)
        
        useCase.execute(request: .init(itemOnListUUID: "myItemOnListID",
                                       listUUID: mockListRepository!.list.first!.uuid,
                                       itemUUID: mockItemOnListRepository!.items.first!.uuid,
                                       newQuantity: 2))
            .then { (response) in
                XCTAssert(response.list.getItemsFromList().first?.quantity == 2)
                expectation.fulfill()
            }.catch { error in
                XCTFail()
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
