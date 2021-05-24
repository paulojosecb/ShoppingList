//
//  AddItemOnListUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 21/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class AddItemOnListUseCaseTest: XCTestCase {
    
    var mockListRepository: MockListRepository? = nil
    var mockItemRepository: MockItemRepository? = nil
        
    class MockListRepository: ICRUDRepository {

        var errorMock = false
        var list: [List] = []
        var items: [Item] = [
            Item(name: "My Item", initialPrice: nil),
            Item(name: "My Item1", initialPrice: nil),
            Item(name: "My Item2", initialPrice: nil)
        ]
        
        func fetch<T: Fetchable>(uuid: String) -> Promise<T> {
            return Promise { fullfill, reject in
                guard let list = (self.list.first { $0.uuid == uuid}) as? T  else {
                    reject(ICRUDRepositoryError.notFound)
                    return
                }
                
                fullfill(list)
            }
        }
        
        func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
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
        mockListRepository = MockListRepository()
        mockItemRepository = MockItemRepository()
        mockListRepository?.list.append(List("My list"))
    }
    
    override func tearDown() {
        mockListRepository = nil
    }
    
    func testAddItemOnList() {
        let expectation = XCTestExpectation(description: "Add Item On List")
        let useCase = AddItemOnListUseCase(listRepository: mockListRepository!,
                                           itemRepository: mockItemRepository!)
        
        let list =  mockListRepository!.list.first!
        let item = mockItemRepository!.items.first!
        
        useCase.execute(request: .init(listUUID: list.uuid,
                                       itemUUID: item.uuid,
                                       quantity: 1))
        .then { (response) in
            let listContaisItem = response.list.getItemsFromList().contains { $0.itemUUID == item.uuid }
            
            XCTAssertTrue(response.list.getItemsFromList().count == 1)
            XCTAssertTrue(listContaisItem)
            XCTAssertTrue(response.list.getItemsFromList().first?.quantity == 1)

            expectation.fulfill()
        }.catch { (error) in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testAddItemThatDoesNotExists() {
        let expectation = XCTestExpectation(description: "Add Item On List that does not exists")
        let useCase = AddItemOnListUseCase(listRepository: mockListRepository!,
                                           itemRepository: mockItemRepository!)
        
        let list =  mockListRepository!.list.first!
        let item = mockItemRepository!.items.first!
        
        useCase.execute(request: .init(listUUID: list.uuid,
                                       itemUUID: UUID().uuidString,
                                       quantity: 1))
        .then { (response) in
            XCTFail()
        }.catch { (error) in
            
            if error is IAddItemOnListUseCaseError {
                XCTAssert(error as! IAddItemOnListUseCaseError == IAddItemOnListUseCaseError.itemNotFound)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testAddItemThatIsAlreadyOnList() {
        let expectation = XCTestExpectation(description: "Add Item On List that is already on list")
        let useCase = AddItemOnListUseCase(listRepository: mockListRepository!,
                                           itemRepository: mockItemRepository!)
        
        let list =  mockListRepository!.list.first!
        let item = mockItemRepository!.items.first!
    
        
        useCase.execute(request: .init(listUUID: list.uuid,
                                       itemUUID: item.uuid,
                                       quantity: 1))
        .then { (response) -> Promise<IAddItemOnListUseCaseResponse> in
            return useCase.execute(request: .init(listUUID: list.uuid,
                                                  itemUUID: item.uuid,
                                                  quantity: 2))
        }.then { (response) in
            XCTFail()
        }.catch { (error) in
            
            if error is IAddItemOnListUseCaseError {
                XCTAssert(error as! IAddItemOnListUseCaseError == IAddItemOnListUseCaseError.itemAlreadyOnList)
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
