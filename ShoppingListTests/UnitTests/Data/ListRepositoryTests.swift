//
//  ListRepositoryTests.swift
//  ShoppingListTests
//
//  Created by Paulo José on 07/05/21.
//

import XCTest
import Promises
import CoreData
@testable import ShoppingList

class ListRepositoryTests: XCTestCase {
    
    var repository: ListRepository!
    var coreDataStack: CoreDataStack!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        repository = ListRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDown() {
        super.tearDown()
        repository = nil
        coreDataStack = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateList() {
        let list = List("My list")
        let expectation = XCTestExpectation(description: "List with name")

        repository.create(list).then { (list) in
            self.fetchListWith(uuid: list.uuid)
        }.then { (cdList) in
            return Promise<CDList> { fulfill, reject in
                XCTAssertTrue(cdList.name == list.name)
                XCTAssertTrue(cdList.uuid == list.uuid)
                XCTAssertTrue(cdList.cartUUID == list.cart.uuid)
                
                fulfill(cdList)
            }
        }.then { (cdList) in
            return self.fetchCartWith(listUUID: list.uuid)
        }.then { cart in
            guard let items = cart.items as? [String] else {
                XCTFail()
                return
            }
            
            XCTAssertTrue(items.isEmpty)
            XCTAssertTrue(cart.listUUID == list.uuid)
            
            expectation.fulfill()
        }.catch { _ in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    private func fetchListWith(uuid: String) -> Promise<CDList> {
        return Promise<CDList> { fulfill, reject in
            do {
                let request: NSFetchRequest<CDList> = CDList.fetchRequest()
                request.predicate = NSPredicate(format: "uuid == %@", uuid)
                
                let cdList = try? self.coreDataStack.mainContext.fetch(request).first
                
                fulfill(cdList!)
            } catch _ {
                reject(ICRUDRepositoryError.notFound)
            }
        }
    }
    
    private func fetchCartWith(listUUID: String) -> Promise<CDCart> {
        return Promise<CDCart> { fulfill, reject in
            do {
                let request: NSFetchRequest<CDCart> = CDCart.fetchRequest()
                request.predicate = NSPredicate(format: "listUUID == %@", listUUID)
                
                let cdCart = try? self.coreDataStack.mainContext.fetch(request).first
                
                fulfill(cdCart!)
            } catch _ {
                reject(ICRUDRepositoryError.notFound)
            }
        }
    }

}
