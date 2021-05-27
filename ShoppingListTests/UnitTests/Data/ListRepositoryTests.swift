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
    
    func testFetchList() {
        let list = List("My list")
        let expectation = XCTestExpectation(description: "List with name")
        
        let item = Item(name: "My Item", initialPrice: nil)
        let itemTwo = Item(name: "My Item Two", initialPrice: nil)
        
        let itemOnList = ItemOnList(item: item.uuid,
                                    on: list.uuid,
                                    quantity: 1,
                                    unitPrice: nil, uuid: nil)
        let itemOnListTwo = ItemOnList(item: itemTwo.uuid,
                                       on: list.uuid,
                                       quantity: 1,
                                       unitPrice: nil,
                                       uuid: nil)
        
        try! list.addItemToList(itemOnList)
        try! list.addItemToList(itemOnListTwo)
        
        try! list.moveItemToCart(itemUUID: itemTwo.uuid)
        
        repository.create(list)
            .then { (createdList: List) in
            self.repository.fetch(uuid: createdList.uuid)
            }
            .then { (fetchedList: List) in
            XCTAssertTrue(fetchedList.getItemsFromList().count == 1)
            XCTAssertTrue(fetchedList.getItemsFromCart().count == 1)
            
            XCTAssertTrue(fetchedList.getItemsFromList().first?.itemUUID == itemOnList.itemUUID)
            XCTAssertTrue(fetchedList.getItemsFromList().first?.listUUID == itemOnList.listUUID)

            XCTAssertTrue(fetchedList.getItemsFromCart().first?.itemUUID == itemOnListTwo.itemUUID)
            XCTAssertTrue(fetchedList.getItemsFromList().first?.listUUID == itemOnListTwo.listUUID)
            
            XCTAssertTrue(fetchedList.uuid == list.uuid)
            XCTAssertTrue(fetchedList.name == list.name)
            
            expectation.fulfill()
        }.catch { _ in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDeleteList() {
        let list = List("My List")
        let expectation = XCTestExpectation(description: "Test delete of list that exists")
        
        var wasCreated = false
        
        self.repository.create(list).then { (list) in
            return self.fetchListWith(uuid: list.uuid)
        }.then { (cdList) -> Promise<Bool> in
            if (list.uuid == cdList.uuid) {
                wasCreated = true
            }
            
            return self.repository.delete(list)
        }.then { (deleted) in
            
            let request: NSFetchRequest<CDList> = CDList.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", list.uuid)
            
            let returnCdList = try? self.coreDataStack.mainContext.fetch(request).first
            
            if (returnCdList == nil && wasCreated) {
                XCTAssert(true)
                expectation.fulfill()
            } else {
                XCTFail()
            }
            
        }.catch { (_) in
            XCTFail()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testDeleteListThatDoesNotExists() {
        let list = List("My List")
        let expectation = XCTestExpectation(description: "Test delete of list that does not exists")
        
        var wasCreated = false
        
        self.repository.delete(list).then { (deleted) in
            XCTFail()
        }.catch { (error) in
            if let error = error as? ICRUDRepositoryError,
               error == ICRUDRepositoryError.notFound {
                XCTAssert(true)
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    private func fetchListWith(uuid: String) -> Promise<CDList> {
        return Promise<CDList> { fulfill, reject in
            let request: NSFetchRequest<CDList> = CDList.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", uuid)
            
            let cdList = try? self.coreDataStack.mainContext.fetch(request).first
            
            fulfill(cdList!)
        }
    }
    
    private func fetchCartWith(listUUID: String) -> Promise<CDCart> {
        return Promise<CDCart> { fulfill, reject in
            let request: NSFetchRequest<CDCart> = CDCart.fetchRequest()
            request.predicate = NSPredicate(format: "listUUID == %@", listUUID)
            
            let cdCart = try? self.coreDataStack.mainContext.fetch(request).first
            
            fulfill(cdCart!)
        }
    }

}
