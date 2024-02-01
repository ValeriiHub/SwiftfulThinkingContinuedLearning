//
//  CoreDataManager.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 25.07.2023.
//

import SwiftUI
import CoreData

class CoreDataManager {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext

    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATE. \(error)")
            }
        }

        context = container.viewContext
    }

    // SAVE
    func save() {
        do {
            try context.save()
            print("Saved succesfully")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}
