//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var textA = ""
    @Published var textB = ""
    
    private let sampleString = "Hello World!"
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        sampleString.publisher
            .compactMap( { String($0) } )
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellables)
        
        Just(sampleString)
            .compactMap( { String($0) } )
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellables)
                print($0)
            })
//            .assign(to: \.textB, on: self)
            .store(in: &cancellables)
    }
}
