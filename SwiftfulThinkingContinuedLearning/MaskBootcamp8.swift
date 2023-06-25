//
//  MaskBootcamp8.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 25.06.2023.
//

import SwiftUI

struct MaskBootcamp8: View {
    
    @State var rating = 3
    
    var body: some View {
        ZStack {
            starsView
                .overlay {
                    overlayView
                        .mask(starsView)
                }
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
//                    .foregroundColor(.yellow)
                    .fill(LinearGradient(colors: [.red, .blue], startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(rating >= index ? Color.yellow : .gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index

                        }
                    }
            }
        }
    }
}

struct MaskBootcamp8_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp8()
    }
}
