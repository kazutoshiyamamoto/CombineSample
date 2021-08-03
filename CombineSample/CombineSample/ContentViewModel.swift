//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var text = ""
    @Published var filteredText = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $text
            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
//            .filter( { $0.isAlphanumeric() } )
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
            .receive(on: RunLoop.main)
            .assign(to: \.filteredText, on: self)
            .store(in: &cancellables)
    }
}

//extension String {
//    // 半角数字の判定
//    func isAlphanumeric() -> Bool {
//        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
//    }
//}
