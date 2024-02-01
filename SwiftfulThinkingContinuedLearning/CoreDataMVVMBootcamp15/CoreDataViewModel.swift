//
//  CoreDataViewModel.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 12.05.2023.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATE. \(error)")
            }
        }
        
        fetchFruits()
    }
    
    // FETCH
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    // SAVE
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    // ADD
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    // UPDATE
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    // DELETE
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
}
