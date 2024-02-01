//
//  DragGectureBootcamp4.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 03.04.2023.
//

import SwiftUI

struct DragGectureBootcamp4: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
       RoundedRectangle(cornerRadius: 20)
            .frame(width: 100, height: 100)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            offset = value.translation
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            offset = .zero
                        }
                    }
            )
        
        ZStack {
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
        
            RoundedRectangle(cornerRadius: 20)
                 .frame(width: 300, height: 500)
                 .offset(offset)
                 .scaleEffect(getScaleAmount())
                 .rotationEffect(Angle(degrees: getRotationAmount()))
                 .gesture(
                     DragGesture()
                         .onChanged { value in
                             withAnimation(.spring()) {
                                 offset = value.translation
                             }
                         }
                         .onEnded { value in
                             withAnimation(.spring()) {
                                 offset = .zero
                             }
                         }
             )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1 - min(percentage, 0.5) / 2
    }
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10.0
        return percentageAsDouble * maxAngle
    }
}

struct DragGectureBootcamp4_Previews: PreviewProvider {
    static var previews: some View {
        DragGectureBootcamp4()
    }
}
