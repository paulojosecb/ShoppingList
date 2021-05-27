//
//  SaveListAsTemplateUseCase.swift
//  ShoppingListTests
//
//  Created by Paulo José on 27/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class SaveListAsTemplateUseCaseTest: XCTestCase {
    
    var repository: MockListRepository? = nil
    
    override func setUp() {
        repository = MockListRepository()
    }
    
    override func tearDown() {
        repository = nil
    }

    func testCreateTemplate() {
        let expectation = XCTestExpectation(description: "Teste create list as template")
        let useCase = SaveListAsTemplateUseCase(repository: repository!)
        
        useCase.execute(request: .init(uuid: repository!.list.first!.uuid))
            .then { response in
                XCTAssertTrue(response.templateList.isTemplate)
                XCTAssertTrue(response.templateList.name == "Template - \(self.repository!.list.first!.name)")
                
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        wait(for: [expectation], timeout: 2)
    }

}
