//
//  CoreDataManager.swift
//  toDoList
//
//  Created by Мира Зейнурова on 10.02.2023.

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init () {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "toDoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    func getResultContainer(entityName: String, sortingKey: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        let sortDiscriptor = NSSortDescriptor(key: sortingKey, ascending: true)
        request.sortDescriptors = [sortDiscriptor]
        
        let resultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return resultController
    }
    
    func getEntity(name: String) -> NSEntityDescription {
        NSEntityDescription.entity(forEntityName: name, in: context)!
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror)")
            }
        }
    }
    
    func createObject(name: String, deadline: String) {
        let entity = getEntity(name: "ToDoListItem")
        let managedObject = ToDoListItem(entity: entity, insertInto: context)
        
        managedObject.name = name
        managedObject.deadline = deadline
        saveContext()
    }
    
        func deleteAll() {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListItem")
            do {
                let results = try context.fetch(fetchRequest) as! [NSManagedObject]
                for result in results{
                    context.delete(result)
                }
                saveContext()
            } catch {
                print(error)
            }
        }
    
    func printAllObects() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListItem")
        
        do{
            let results = try context.fetch(fetchRequest) as! [ToDoListItem]
            for result in results {
                let name = result.name!
                let deadline = result.deadline
            }
        } catch {
            print(error)
        }
    }
}
