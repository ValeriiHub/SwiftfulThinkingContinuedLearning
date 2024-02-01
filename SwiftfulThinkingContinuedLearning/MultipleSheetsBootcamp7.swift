//
//  MultipleSheetsBootcamp7.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 25.06.2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item

struct MultipleSheetsBootcamp7: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting title")
    @State var showSheet = false
//    @State var showSheet2 = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "One")
                showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                NextScreen(selectedModel: RandomModel(title: "One"))
//            }
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "Two")
                showSheet.toggle()
            }
//            .sheet(isPresented: $showSheet) {
//                NextScreen(selectedModel: RandomModel(title: "Two"))
//            }
        }
        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: $selectedModel)
            NextScreen(selectedModel: selectedModel)
        }
    }
}

struct MultipleSheetsBootcamp7_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp7()
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
//    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
    }
}
