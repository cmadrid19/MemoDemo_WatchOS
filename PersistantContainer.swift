//
//  PersistantContainer.swift
//  CoreDataMemoWatchOS WatchKit Extension
//
//  Created by Maxim Macari on 15/2/21.
//

import CoreData

struct PersistanceController {
    static let shared = PersistanceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Task")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error.userInfo)")
            }
        }
    }
}
