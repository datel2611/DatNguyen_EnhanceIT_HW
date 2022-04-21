//
//  CoreDataManager.swift
//  DN_Homework_3
//
//  Created by Consultant on 29/01/1401 AP.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var mainContext: NSManagedObjectContext { get }
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Favourite")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}
