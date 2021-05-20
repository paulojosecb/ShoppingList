//
//  ListTests.swift
//  ShoppingListTests
//
//  Created by Paulo José on 05/05/21.
//

import XCTest
import Promises
@testable import ShoppingList

class ListTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInit() {
        let listName = "My List Name"
        let list = List(listName)
        XCTAssertTrue(list.name == listName)
        XCTAssertTrue(list.getItemsFromCart().isEmpty)
        XCTAssertTrue(list.getItemsFromList().isEmpty)
    }
    
    func testAddItemToList() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
        
        try! list.addItemToList(itemOnList)
        
        XCTAssertTrue(list.getItemsFromList().contains { $0.itemUUID == item.uuid })
    }
    
    func testAddItemToListWithInvalidListUUID() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: UUID().uuidString, quantity: 1, uuid: nil)
        
        do {
            try list.addItemToList(itemOnList)
            XCTFail()
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            if error == .invalidListUUID {
                XCTAssert(true)
            }
            
        }
    }
    
    
    func testAddItemAlreadyOnList() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
        
        try! list.addItemToList(itemOnList)
        
        do {
            try list.addItemToList(itemOnList)
    
            XCTFail()
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            if error == .itemAlreadyOnList {
                XCTAssert(true)
            }
            
        }
    }
    
    func testAddItemAlreadyOnCart() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
        
        try! list.addItemToList(itemOnList)
        try! list.moveItemToCart(itemUUID: item.uuid)
        
        do {
            try list.addItemToList(itemOnList)
    
            XCTFail()
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            if error == .itemAlreadyOnList {
                XCTAssert(true)
            }
            
        }
    }
    
    func testMoveItemToCart() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
        
        try! list.addItemToList(itemOnList)
        
        do {
            try list.moveItemToCart(itemUUID: item.uuid)
        } catch _ {
            XCTFail()
        }
        
        XCTAssertTrue(!list.getItemsFromCart().isEmpty)
        XCTAssertTrue(list.getItemsFromCart().contains { $0.itemUUID == item.uuid })
    }
    
    func testMoveItemToCartThatDoesExistOnList() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        _ = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
                
        do {
            try list.moveItemToCart(itemUUID: item.uuid)
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            XCTAssertTrue(error == .itemNotFoundOnList)
        }
    }
    
    func testMoveItemToCartThatIsAlreadyOnCart() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
                
        try! list.addItemToList(itemOnList)
        try! list.moveItemToCart(itemUUID: item.uuid)
        
        do {
            try list.moveItemToCart(itemUUID: item.uuid)
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            XCTAssertTrue(error == .itemAlreadyOnCart)
        }
    }
    
    func testMoveItemOutOfCart() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        let itemOnList = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
                
        try! list.addItemToList(itemOnList)
        try! list.moveItemToCart(itemUUID: item.uuid)
        
        do {
            try list.moveItemOutOfCart(itemUUID: item.uuid)
        } catch _ {
            XCTFail()
        }
        
        XCTAssertTrue(!list.getItemsFromCart().contains { $0.itemUUID == item.uuid })
        XCTAssertTrue(list.getItemsFromList().contains { $0.itemUUID == item.uuid })
    }
    
    func testMoveItemOutOfCartThatIsNotOnCart() {
        let item = Item(name: "My Item", initialPrice: nil)
        let list = List("My list")
        _ = ItemOnList(item: item.uuid, on: list.uuid, quantity: 1, uuid: nil)
                        
        do {
            try list.moveItemOutOfCart(itemUUID: item.uuid)
        } catch let error {
            guard let error = error as? List.CustomError else {
                XCTFail()
                return
            }
            
            XCTAssertTrue(error == .itemNotFoundOnCart)
        }
    }
    
    
}
