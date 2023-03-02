//
//  ToDoListItem+CoreDataProperties.swift
//  toDoList
//
//  Created by Мира Зейнурова on 10.02.2023.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var deadline: String?

}

extension ToDoListItem : Identifiable {

}
