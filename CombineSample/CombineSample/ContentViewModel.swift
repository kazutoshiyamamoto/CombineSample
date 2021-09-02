//
//  ContentViewModel.swift
//  CombineSample
//
//  Created by home on 2021/07/30.
//

import SwiftUI
import Combine

final class ContentViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
//    lazy var doSomethingSubject = myDoSomethingSubject.eraseToAnyPublisher()
    private lazy var subject = PassthroughSubject<Int, Error>()
    
    enum SampleError: Error {
        case error
    }
    
    init() {
        myDoSomethingSubject
            .sink() {
                print("Did something with Combine.")
            }
        
        subject
            .sink(receiveCompletion: {
                print ("completion:\($0)")
            },
            receiveValue: {
                // do something
                print("\($0)")
            })
            .store(in: &cancellables)
    }
    
    func onTapped() {
        myDoSomethingSubject.send()
//        myDoSomethingSubject.send(completion: .finished)
        // sendの挙動チェック
        let randomNumber = Int.random(in: 1...10)
        subject.send(randomNumber)
        
        // 終了する挙動を確認したい場合は、以下のコメントアウトを外す
        //        subject.send(completion: .finished)
        
        // エラーで終了する挙動を確認したい場合は、以下のコメントアウトを外す
        //        subject.send(completion: .failure(SampleError.error))
    }
    
    
    //    func onDoSomething(completionHandler: @escaping () -> Void) {
    //        print("onDoSomething")
    //        completionHandler()
    //    }
}
