//
//  EscapingBootcamp20.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Valerii on 07.03.2024.
//

import SwiftUI

final class EscapingViewModel: ObservableObject {
    
    @Published var text = "Hello"
    
    func getDate() {
        downloadDate5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
        
    }
    
    func downloadDate() -> String {
        return "New data!"
    }
    
    func downloadDate2(copmletionHandler: (_ data: String) -> ()) {
        copmletionHandler("New data!")
    }
    
    func downloadDate3(copmletionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            copmletionHandler("New data!")
        }
    }
    
    func downloadDate4(copmletionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data!")
            copmletionHandler(result)
        }
    }
    
    func downloadDate5(copmletionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data!")
            copmletionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp20: View {
    
    @StateObject private var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getDate()
            }
    }
}

#Preview {
    EscapingBootcamp20()
}
