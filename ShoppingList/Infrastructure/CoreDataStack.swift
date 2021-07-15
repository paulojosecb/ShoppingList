//
//  CoreDataManager.swift
//  ShoppingList
//
//  Created by Paulo José on 06/05/21.
//

import Foundation
import CoreData

open class CoreDataStack {
  public static let modelName = "ShoppingList"

  public static let model: NSManagedObjectModel = {
    // swiftlint:disable force_unwrapping
    let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
    return NSManagedObjectModel(contentsOf: modelURL)!
  }()
  // swiftlint:enable force_unwrapping

  public init() {
  }

  public lazy var mainContext: NSManagedObjectContext = {
    return storeContainer.viewContext
  }()

  public lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
    container.loadPersistentStores { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()

  public func newDerivedContext() -> NSManagedObjectContext {
    let context = storeContainer.newBackgroundContext()
    return context
  }

  public func saveContext() {
    saveContext(mainContext)
  }

  public func saveContext(_ context: NSManagedObjectContext) {
    if context != mainContext {
      saveDerivedContext(context)
      return
    }

    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }

  public func saveDerivedContext(_ context: NSManagedObjectContext) {
    context.perform {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }

      self.saveContext(self.mainContext)
    }
  }
    
    public func fetch(by uuid: String) -> CDItem? {
        do {
            let request: NSFetchRequest<CDItem>  = CDItem.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", uuid)
            
            let item = try self.mainContext.fetch(request).first
            return item
        } catch _ {
            return nil
        }
    }
    
    public func fetch(by uuid: String) -> CDList? {
        do {
            let request: NSFetchRequest<CDList>  = CDList.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", uuid)
            
            let item = try self.mainContext.fetch(request).first
            return item
        } catch _ {
            return nil
        }
    }
    
    public func fetch(by uuid: String) -> CDItemOnList? {
        do {
            let request: NSFetchRequest<CDItemOnList>  = CDItemOnList.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", uuid)
            
            let item = try self.mainContext.fetch(request).first
            return item
        } catch _ {
            return nil
        }
    }
    
    public func fetch(by uuid: String) -> CDCheckout? {
        do {
            let request: NSFetchRequest<CDCheckout>  = CDCheckout.fetchRequest()
            request.predicate = NSPredicate(format: "uuid == %@", uuid)
            
            let item = try self.mainContext.fetch(request).first
            return item
        } catch _ {
            return nil
        }
    }
    
    public func fetchItemsOnList(by uuids: [String]) -> [CDItemOnList]? {
        do {
            let request: NSFetchRequest<CDItemOnList>  = CDItemOnList.fetchRequest()
            
            let item = try self.mainContext.fetch(request)

            return item.filter { uuids.contains($0.uuid!) }
        } catch _ {
            return nil
        }
    }
    
    public func fetchItemsByNames(query: String) -> [CDItem] {
        do {
            let request: NSFetchRequest<CDItem>  = CDItem.fetchRequest()
            request.predicate = NSPredicate(format: "name CONTAINS[C] %@", query)
            
            let lists = try self.mainContext.fetch(request)

            return lists 
        } catch _ {
            return []
        }
    }
    
}

