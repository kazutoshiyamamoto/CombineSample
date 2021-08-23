//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    @Published var count = 0
    private let endCount: Int = 10000
    
    //    @Published var isTimerRunning = false
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = Timer.publish(every: 0.001, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                var additionNumbers: Int {
                    switch self.endCount {
                    case 0 ..< 1000:
                        return 1
                    case 1000 ..< 5000:
                        return 5
                    case 5000 ..< 10000:
                        return 10
                    case 10000 ..< 50000:
                        return 50
                    case 50000 ..< 100000:
                        return 100
                    case 100000 ..< 500000:
                        return 500
                    case 500000 ..< 1000000:
                        return 1000
                    case 1000000 ..< 10000000:
                        return 5000
                    default:
                        return 10000
                    }
                }
                
                if self.count < self.endCount {
                    self.count += additionNumbers
                } else {
                    self.count = self.endCount
                    self.cancellable?.cancel()
                }
            }
    }
    
    //    func startCounting() {
    //        isTimerRunning = true
    //        cancellable = Timer.publish(every: 1.0, on: .main, in: .common)
    //            .autoconnect()
    //            .sink { _ in
    //                self.count += 1
    //            }
    //    }
    //
    //    func stopCounting() {
    //        isTimerRunning = false
    //        cancellable?.cancel()
    //    }
    //
    //    func resetCount() {
    //        count = 0
    //    }
}
