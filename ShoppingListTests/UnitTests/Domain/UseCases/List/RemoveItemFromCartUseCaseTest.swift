//
//  RemoveItemFromCartUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 05/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class RemoveItemFromCartUseCaseTest: XCTestCase {
    
    var list: List? = nil
    var item: Item? = nil
    
    var mockRepository: MockRemoveItemFromCartRepository? = nil
    
    class MockRemoveItemFromCartRepository: ICRUDRepository {

        var errorMock = false
        var list: [List] = []
        
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
            return Promise { fulfill, reject in
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
        mockRepository = MockRemoveItemFromCartRepository()
        
        list = List("My list")
        item = Item(name: "My Item", initialPrice: nil)
    }
    
    override func tearDown() {
        mockRepository = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRemoveItemFromCartThatExistsTest() {
        let expectation = XCTestExpectation(description: "List with name")
        let useCase = RemoveItemFromCartUseCase(repository: mockRepository!)
        let itemOnList = ItemOnList(item: item!.uuid, on: list!.uuid, quantity: 1, unitPrice: nil, uuid: nil)
        
        try! list?.addItemToList(itemOnList)
        try! list?.moveItemToCart(itemUUID: item!.uuid)
        
        mockRepository?.create(list!).then { (list: List) in
            
            let request = IRemoveItemFromCartUseCaseRequest(listUUID: list.uuid, itemUUID: self.item!.uuid)
            
            useCase.execute(request: request).then { response in
                
                let listContainsItem = response.list.getItemsFromList().contains { $0.itemUUID == self.item?.uuid }
                let cartContainsItem = response.list.getItemsFromCart().contains { $0.itemUUID == self.item?.uuid }
                
                XCTAssertTrue(listContainsItem)
                XCTAssertTrue(!cartContainsItem)
                
                expectation.fulfill()
                
            }.catch { (error) in
                XCTFail()
            }
    
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRemoveItemFromCartThatDoesNotExistsTest() {
        let expectation = XCTestExpectation(description: "List with name")
        let useCase = RemoveItemFromCartUseCase(repository: mockRepository!)
        let itemOnList = ItemOnList(item: item!.uuid, on: list!.uuid, quantity: 1, unitPrice: nil, uuid: nil)
        
        try! list?.addItemToList(itemOnList)
        
        mockRepository?.create(list!).then { (list: List) in
            
            let request = IRemoveItemFromCartUseCaseRequest(listUUID: list.uuid, itemUUID: self.item!.uuid)
            
            useCase.execute(request: request).then { response in
                
                XCTFail()
                
            }.catch { (error) in
                expectation.fulfill()
            }
    
        }
        
        wait(for: [expectation], timeout: 1.0)
    }


}
