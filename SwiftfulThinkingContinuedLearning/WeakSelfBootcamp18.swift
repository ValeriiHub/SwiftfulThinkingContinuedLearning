//
//  WeakSelfBootcamp18.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Valerii on 07.03.2024.
//

import SwiftUI

struct WeakSelfBootcamp18: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate") {
                WeakSelSecondScreen()
            }
            .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10)),
            alignment: .topTrailing
        )
    }
}

import Foundation

final class WeakSelSecondScreenViewModel: ObservableObject {
        
    @Published var data: String? = nil
    
    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount - 1, forKey: "count")
    }

    func getData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 50) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
    }
}

struct WeakSelSecondScreen: View {
    
    @StateObject private var vm = WeakSelSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

#Preview {
    WeakSelfBootcamp18()
}
