//
//  GeometryReaderBootcamp6.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 31.03.2023.
//

import SwiftUI

struct GeometryReaderBootcamp6: View {
    var body: some View {
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//
//                Rectangle()
//                    .fill(Color.blue)
//
//            }
//            .ignoresSafeArea()
//        }
        
        
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { _ in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0, y: 1, z: 0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp6_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp6()
    }
}
