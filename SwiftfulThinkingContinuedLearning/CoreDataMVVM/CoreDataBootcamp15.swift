//
//  CoreDataBootcamp15.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 12.05.2023.
//

import SwiftUI
import CoreData

struct CoreDataBootcamp15: View {
    
    @StateObject var vm = CoreDataViewModel()
    
    @State var textFieldText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // TEXT FIELD
                TextField("Add fruit here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // BUTTON
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(text: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                  
                // LIST
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "NO NAME")
                            .onTapGesture {
                                vm.updateFruit(entity: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
            }
            .navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp15_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp15()
    }
}
