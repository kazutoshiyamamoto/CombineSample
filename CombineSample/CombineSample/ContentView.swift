//
//  ContentView.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI
import Combine

struct ContentView: View {
    private let sampleNotification = Notification.Name("sampleNotification")
    
    private var cancellable: AnyCancellable?
    
    init() {
        cancellable = NotificationCenter.default.publisher(for: sampleNotification, object: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            },
            receiveValue: { _ in
                print("Receive notification")
            })
    }
    
    var body: some View {
        Button(action: {
            NotificationCenter.default.post(name: sampleNotification, object: nil)
        }, label: {
            Text("Send notification")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
