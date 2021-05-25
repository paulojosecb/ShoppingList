//
//  GetListUseCaseTest.swift
//  ShoppingListTests
//
//  Created by Paulo José on 25/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class GetListUseCaseTest: XCTestCase {
    
    var repository: MockListRepository? = nil
    
    override func setUp() {
        repository = MockListRepository()
    }
    
    override func tearDown() {
        repository = nil
    }
    
    func testGetList() {
        let expectation = XCTestExpectation(description: "Get list")
        let useCase = GetListUseCase(repository: self.repository!)
        
        let list = self.repository!.list.first!
        
        useCase.execute(request: .init(uuid: list.uuid))
            .then { response in
                XCTAssertTrue(response.list.uuid == list.uuid)
                XCTAssertTrue(response.list.name == list.name)
                
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testGetInvalidList() {
        let expectation = XCTestExpectation(description: "Get list")
        let useCase = GetListUseCase(repository: self.repository!)
        
        useCase.execute(request: .init(uuid: "Olá"))
            .then { response in
                XCTFail()
            }
            .catch { error in
                if let error = error as? IGetListUseCaseError,
                   error == .listNotFound {
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
