//
//  DragGectureBootcamp4 vol.2.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 03.04.2023.
//

import SwiftUI

struct DragGectureBootcamp4_vol_2: View {
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                    
                                currentDragOffsetY = 0
                            }
                        }
                )
            
            VStack(alignment: .leading) {
                Text("currentDragOffsetY = \(startingOffsetY)")
                Text("currentDragOffsetY = \(currentDragOffsetY)")
                Text("currentDragOffsetY = \(endingOffsetY)")
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGectureBootcamp4_vol_2_Previews: PreviewProvider {
    static var previews: some View {
        DragGectureBootcamp4_vol_2()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app")
                .multilineTextAlignment(.center)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
