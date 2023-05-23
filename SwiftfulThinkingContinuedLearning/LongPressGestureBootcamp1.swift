//
//  ContentView.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 05.02.2023.
//

import SwiftUI

struct LongPressGestureBootcamp1: View {
    
    @State private var isComplete = false
    @State private var isSuccess = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Click here")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 3,
                                        maximumDistance: 50) {
                        // at the min duration
                        withAnimation(.easeInOut(duration: 1)) {
                            isSuccess.toggle()
                        }
                    } onPressingChanged: { isPressed in
                        // start of press -> to min duration
                        if isPressed {
                            withAnimation(.easeInOut(duration: 3)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut(duration: 3)) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }
                
                Text("Reset")
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
            }
        }
        
        
//        Text(isComplete ? "Completed" : "Not Completed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : .gray)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 5,        // минимальная длительность жеста после которой выполняеться действие
//                                maximumDistance: 1) {      // максимальная дистанция в которой жест будет выполнен
//                isComplete.toggle()
//            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp1()
    }
}
