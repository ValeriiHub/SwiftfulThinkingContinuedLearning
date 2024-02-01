//
//  SwiftfulThinkingContinuedLearningApp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 05.02.2023.
//

import SwiftUI

@main
struct SwiftfulThinkingContinuedLearningApp: App {
    
    let persistenceController = PersistenceController.shared                                        // core data bootcamp 14
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)   // core data bootcamp 14
        }
    }
}
