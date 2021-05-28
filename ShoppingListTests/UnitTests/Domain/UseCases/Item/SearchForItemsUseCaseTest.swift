//
//  SearchForItemsUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 20/05/21.
//


import XCTest
import Promises
@testable import ShoppingList

class SearchForItemsUseCaseTest: XCTestCase {
    
    var mockRepository: MockSearchForItemsRepository? = nil
    
    class MockSearchForItemsRepository: IItemRepository {

        var errorMock = false
        var items: [Item] = [
            Item(name: "Biscoito", initialPrice: nil),
            Item(name: "Biscoito recheado", initialPrice: nil),
            Item(name: "Bolacha", initialPrice: nil),
        ]
        
        func fetchBy<T>(name: String) -> Promise<[T]> where T : Fetchable {
            return Promise<[T]> { fulfill, reject in
                let itemsToReturn = self.items.filter { $0.name.contains(name) }
                fulfill(itemsToReturn as! [T])
            }
        }
        
        func fetch<T>(uuid: String) -> Promise<T> where T : Fetchable {
            return Promise<T> { fulfill, reject in
                fatalError()
            }
        }
        
        func fetch<T>(uuids: String) -> Promise<[T]> where T : Fetchable {
            return Promise { fulfill, reject in
                
            }
        }
        
        func fetch<T>() -> Promise<[T]> where T : Fetchable {
            return Promise {fulfill, reject in
                fatalError()
            }
        }
        
        func create<T: Fetchable>(_ item: T) -> Promise<T> {
            return Promise { fullfill, reject in
                
            }
        }
        
        func update<T>(_ item: T) -> Promise<T> where T : Fetchable {
            return Promise { fullfill, reject in
     
            }
        }
        
        func delete<T>(_ item: T) -> Promise<Bool> where T : Fetchable {
            return Promise { fullfill, reject in

            }
        }

    }
    
    override func setUp() {
        mockRepository = MockSearchForItemsRepository()
    }
    
    override func tearDown() {
        mockRepository = nil
    }
    
    func testSearchForItemThatExists() {
        let expectation = XCTestExpectation(description: "Search for items by name")
        let useCase = SearchForItemsUseCase(repository: mockRepository!)

        useCase.execute(request: .init(query: "Biscoito")).then { response in
            XCTAssert(response.item.count == 2)
            expectation.fulfill()
        }.catch { (_) in
            XCTFail()
        }
    
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchForItemThatWithOnlyOneLetterExists() {
        let expectation = XCTestExpectation(description: "Search for items by name")
        let useCase = SearchForItemsUseCase(repository: mockRepository!)

        useCase.execute(request: .init(query: "B")).then { response in
            XCTAssert(response.item.count == 3)
            expectation.fulfill()
        }.catch { (_) in
            XCTFail()
        }
    
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchForItemThatDoesNotExists() {
        let expectation = XCTestExpectation(description: "Search for items by name")
        let useCase = SearchForItemsUseCase(repository: mockRepository!)

        useCase.execute(request: .init(query: "Coca-cola")).then { response in
            XCTAssert(response.item.count == 0)
            expectation.fulfill()
        }.catch { (_) in
            XCTFail()
        }
    
        wait(for: [expectation], timeout: 2)
    }
    
    func testSearchForEmptyQuerytExists() {
        let expectation = XCTestExpectation(description: "Search for items by name")
        let useCase = SearchForItemsUseCase(repository: mockRepository!)

        useCase.execute(request: .init(query: "")).then { response in
            XCTFail()
        }.catch { (error) in
            if let error = error as? ISearchForItemsUseCaseError,
               error == .invalidQuery {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
    
        wait(for: [expectation], timeout: 2)
    }

}
