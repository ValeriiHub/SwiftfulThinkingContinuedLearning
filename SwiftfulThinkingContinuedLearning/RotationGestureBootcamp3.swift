//
//  RotationGestureBootcamp3.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 24.05.2023.
//

import SwiftUI

struct RotationGestureBootcamp3: View {
    
    @State private var angle = Angle(degrees: 0)
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)                     // добавляем rotationEffect
            .gesture(
                RotationGesture()
                    .onChanged { value  in             // меняем rotationEffect по жесту вращения
                        angle = value
                    }
                    .onEnded { value in                // возврацаем в начальньое положени по окнчанию жеста
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureBootcamp3_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp3()
    }
}
