//
//  ContentView.swift
//  CoreDataBootcamp14
//
//  Created by Valerii on 01.02.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: FruitsEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitsEntity.name, ascending: true)])
    private var fruits: FetchedResults<FruitsEntity>

    @State var textFieldText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    addItem()
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                List {
                    ForEach(fruits) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                updateItem(fruit: fruit)
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Fruits")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }

    // ADD
    private func addItem() {
        withAnimation {
            let newFruit = FruitsEntity(context: viewContext)
            newFruit.name = textFieldText

            saveItems()
            textFieldText = ""
        }
    }
    
    // UPDATE
    private func updateItem(fruit: FruitsEntity)  {
        withAnimation {
            let currentName = fruit.name ?? ""
            let newName = currentName + "!"
            fruit.name = newName
            
            saveItems()
        }
    }
    
    // DELETE
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
//            offsets.map { fruits[$0] }.forEach(viewContext.delete)
            
            guard let index = offsets.first else { return }
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)

            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
