//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    @Published var count = 0
    private let endCount: Int = 20
    
    @Published var isCountingCompleted = false
    
    
    init() {
        
    }
}
