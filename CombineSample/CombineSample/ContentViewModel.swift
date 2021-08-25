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
    
    //    func startCounting(completionHandler: @escaping () -> Void) {
    //        Timer.publish(every: 0.1, on: .main, in: .common)
    //            .autoconnect()
    //            .receive(on: RunLoop.main)
    //            .sink { [weak self] _ in
    //                guard let self = self else { return }
    //
    //                if self.count < self.endCount {
    //                    self.count += 1
    //                } else {
    //                    // 処理が終了した時点でcompletionHandler()を呼ぶ
    //                    completionHandler()
    //                }
    //            }
    //            .store(in: &self.cancellables)
    //    }
}
