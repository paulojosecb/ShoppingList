//
//  AddItemOnCartUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 20/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class AddItemOnCartUseCaseTest: XCTestCase {
    
    var list: List? = nil
    var item: Item? = nil
    
    var mockRepository: MockAddItemOnCartRepository? = nil
    
    class MockAddItemOnCartRepository: ICRUDRepository {
        
        var errorMock = false
        var list: [List] = []
        var items: [Item] = []
        
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
            return Promise { fullfill, reject in
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
        mockRepository = MockAddItemOnCartRepository()
        
        list = List("My list")
        item = Item(name: "My Item", initialPrice: nil)
        
    }
    
    override func tearDown() {
        mockRepository = nil
    }
    
    func testAddExistingItemOnCart() {
        let expectation = XCTestExpectation(description: "List with name")
        let useCase = AddItemOnCartUseCase(repository: mockRepository!)
        let itemOnList = ItemOnList(item: item!.uuid, on: list!.uuid, quantity: 1, uuid: nil)
        
        
        try! list?.addItemToList(itemOnList)
        
        mockRepository?.create(list!).then { (list: List) in
            
            let request = IAddItemOnCartUseCaseRequest(listUUID: self.list!.uuid, itemUUID: self.item!.uuid)
            
            useCase.execute(request: request).then { (response: IAddItemOnCartUseCaseResponse) in
                
                let cartContainsItem = response.list.getItemsFromCart().contains { $0.itemUUID == self.item?.uuid }
                
                XCTAssertTrue(cartContainsItem)
                expectation.fulfill()
            }.catch { (_) in
                XCTFail()
            }
            
        }.catch({ (_) in
            XCTFail()
        })
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testAddThatDoesNotExistOnItemOnCart() {
        let expectation = XCTestExpectation(description: "List with name")
        let useCase = AddItemOnCartUseCase(repository: mockRepository!)
                        
        mockRepository?.create(list!).then { (list: List) in
            
            let request = IAddItemOnCartUseCaseRequest(listUUID: self.list!.uuid, itemUUID: self.item!.uuid)
            
            useCase.execute(request: request).then { (response: IAddItemOnCartUseCaseResponse) in
                
                XCTFail()
                
            }.catch { (error) in
                if let error = error as? IAddItemOnCartUseCaseError,
                   error == .itemNotInList {
                    expectation.fulfill()
                }
            }
            
        }.catch({ (_) in
            XCTFail()
        })
        
        wait(for: [expectation], timeout: 5)
    }

    
}
