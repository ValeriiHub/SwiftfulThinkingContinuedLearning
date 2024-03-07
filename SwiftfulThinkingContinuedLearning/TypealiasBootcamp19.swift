//
//  TypealiasBootcamp19.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Valerii on 07.03.2024.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp19: View {
    
//    @State private var item: MovieModel = MovieModel(title: "TV Title", director: "Emmily", count: 10)
    @State private var item: TVModel = TVModel(title: "TV Title", director: "Emmily", count: 10)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
        }
    }
}

#Preview {
    TypealiasBootcamp19()
}
