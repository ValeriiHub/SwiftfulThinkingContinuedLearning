//
//  ArraysBootcamp13.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by User03 on 20.07.2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func getUsers() {
        dataArray = [
            UserModel(name: "Nick1", points: 5, isVerified: true),
            UserModel(name: "Nick2", points: 15, isVerified: false),
            UserModel(name: "Nick3", points: 53, isVerified: true),
            UserModel(name: "Nick4", points: 45, isVerified: false),
            UserModel(name: "Nick5", points: 45, isVerified: true),
            UserModel(name: "Nick6", points: 55, isVerified: true),
            UserModel(name: "Nick7", points: 75, isVerified: false),
            UserModel(name: "Nick8", points: 17, isVerified: false),
            UserModel(name: "Nick9", points: 51, isVerified: true),
            UserModel(name: "Nick10", points: 35, isVerified: true)
        ]
    }
    
    func updateFilteredArray() {
        // sort
        filteredArray = dataArray.sorted { $0.points > $1.points }
        
        // filter
        filteredArray = dataArray.filter { $0.isVerified }
        
        // map
        mappedArray = dataArray.map { $0.name }
        
        // compactMap
        mappedArray = dataArray.compactMap { $0.name }
        
        mappedArray = dataArray
                        .sorted { $0.points > $1.points }
                        .filter { $0.isVerified }
                        .compactMap { $0.name }
        
    }
}

struct ArraysBootcamp13: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
                ForEach(vm.filteredArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)

                        HStack {
                            Text("Points: \(user.points)")

                            Spacer()

                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.blue.cornerRadius(10))
                .padding(.horizontal)
            }
        }
    }
}

struct ArraysBootcamp13_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp13()
    }
}
