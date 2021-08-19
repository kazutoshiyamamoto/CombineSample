//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import Foundation
import Combine

struct SimpleError: Error {}

enum SampleError: Error {
    case error(Error)
}

final class ContentViewModel: ObservableObject {
    @Published var textA = ""
    @Published var textB = ""
    
    private let sampleString = "Hello World!"
    
    private var cancellables: Set<AnyCancellable> = []
    
    let numbers = [5, 4, 3, 2, 1, 0, 9, 8, 7, 6]
    
    @Published var count = 0
    let end: Int = 700000
    private var timerCancellable: AnyCancellable?
    
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
        
        Just(textA)
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellables)
        
        $textA
            .sink(receiveValue: {
                print($0)
            })
            .store(in: &cancellables)
        
        
        numbers.publisher
            .tryLast {
                guard $0 != 0 else {
                    throw SimpleError()
                }
                return true
            }
            .catch({ (error) in
                Just(-1)
            })
            .sink {
                print("\($0)")
            }
            //            .tryLast { _ in
            //                guard 0 != 0  else { throw SimpleError() }
            //            }
            //            .sink(
            //                receiveCompletion: { print ("completion: \($0)", terminator: " ") },
            //                receiveValue: { print ("\($0)", terminator: " ") }
            //            )
            //            .sink {
            //                            print("\($0)")
            //                        }
            .store(in: &cancellables)
        
        timerCancellable = Timer.publish(every: 0.001, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                var numbersToAdd: Int {
                    switch self.end {
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
                
                if self.count < self.end {
                    self.count += numbersToAdd
                } else {
                    self.count = self.end
                    self.timerCancellable?.cancel()
                }
            }
    }
}
