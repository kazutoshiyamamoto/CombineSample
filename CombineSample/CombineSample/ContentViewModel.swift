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
    
    @Published var textA = ""
    
    @Published var textB = ""
    
    @Published var textC = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $textA
            //            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
            //            .filter( { $0.isAlphanumeric() } )
            //            .filter( { $0.hasPrefix("1") } ) // 実際に動かした時に挙動がわかりやすいため追加
            //            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
            //            .receive(on: RunLoop.main)
            //            .assign(to: \.filteredText, on: self)
            .sink(receiveValue: {_ in
                // do something
            })
            .store(in: &cancellables)
        
        $textB
            .sink(receiveValue: {_ in
                // do something
            })
            .store(in: &cancellables)
        
        
        //            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
        //            //            .filter( { $0.isAlphanumeric() } )
        //            //            .filter( { $0.hasPrefix("1") } ) // 実際に動かした時に挙動がわかりやすいため追加
        //            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
        //            .receive(on: RunLoop.main)
        //            .assign(to: \.filteredText, on: self)
        
        $textC
            .sink(receiveValue: {_ in
                // do something
            })
            .store(in: &cancellables)
        
        //            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
        //            //            .filter( { $0.isAlphanumeric() } )
        //            //            .filter( { $0.hasPrefix("1") } ) // 実際に動かした時に挙動がわかりやすいため追加
        //            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // ユーザーの入力が停止するのを待つ
        //            .receive(on: RunLoop.main)
        //            .assign(to: \.filteredText, on: self)
        
        //        $text
        //            .filter( { $0.unicodeScalars.allSatisfy( { CharacterSet.alphanumerics.contains($0) } ) } )
        //            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        //            .receive(on: RunLoop.main)
        //            .assign(to: \.filteredText, on: self)
        //            .store(in: &cancellables)
        
        //        // Justの挙動チェック
        //        cancellable = Just("test")
        //            .sink { message in
        //                print("message: \(message)")
        //            }
    }
}

//extension String {
//    // 半角数字の判定
//    func isAlphanumeric() -> Bool {
//        return self.range(of: "[^0-9]+", options: .regularExpression) == nil && self != ""
//    }
//}
