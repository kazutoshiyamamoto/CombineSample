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
    }
}
