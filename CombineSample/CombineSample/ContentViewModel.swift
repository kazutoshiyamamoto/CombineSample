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
    
    private var cancellable: AnyCancellable?
    
    
    init() {
        cancellable = $text
            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
            .filter( { $0.hasPrefix("1") } ) // 実際に動かした時に挙動がわかりやすいため追加
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
            .receive(on: RunLoop.main)
            .assign(to: \.filteredText, on: self)
        
    }
}
