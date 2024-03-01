//
//  BackgroundThreadBootcamp17.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Valerii on 01.03.2024.
//

import SwiftUI

final class BackgroundThreadViewModel: ObservableObject {
        
    @Published var dataArray: [String] = []
    
    func fetchData() {
        DispatchQueue.global().async {
            let newData = self.downloadData()
            
            
            let isMainThread = Thread.isMainThread  // проверяем находимся ли мы в главной очереди
            let currentThread = Thread.current      // проверяем какая текущая очередь
            
            print("Check 1: \(isMainThread)")
            print("Check 1: \(currentThread)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
}

struct BackgroundThreadView: View {
    
    @StateObject private var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThreadView()
}
