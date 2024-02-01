//
//  ScrollViewReaderBootcamp5.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 31.03.2023.
//

import SwiftUI

struct ScrollViewReaderBootcamp5: View {
    
    @State private var textFieldText: String = ""
    @State private var scrollToIndex = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.spring()) {
//                    proxy.scrollTo(49, anchor: .bottom)
                    
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(scrollToIndex)
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp5_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp5()
    }
}
