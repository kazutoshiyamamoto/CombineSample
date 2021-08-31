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
    
    private lazy var myDoSomethingSubject = PassthroughSubject<Void, Never>()
//    lazy var doSomethingSubject = myDoSomethingSubject.eraseToAnyPublisher()
    
    init() {
        myDoSomethingSubject
            .sink() {
                print("Did something with Combine.")
            }
            .store(in: &cancellables)
    }
    
    func onTapped() {
        myDoSomethingSubject.send()
//        myDoSomethingSubject.send(completion: .finished)
    }
    
    
    //    func onDoSomething(completionHandler: @escaping () -> Void) {
    //        print("onDoSomething")
    //        completionHandler()
    //    }
}
