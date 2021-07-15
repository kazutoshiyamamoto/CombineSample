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
            .compactMap { Int($0.userInfo!["numberString"] as! String) }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("error \(error.localizedDescription)")
                }
            },
            receiveValue: { number in
                print(number)
            })
    }
    
    var body: some View {
        Button(action: {
            NotificationCenter.default.post(
                name: sampleNotification,
                object: nil,
                userInfo: ["numberString": "1"]
            )
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
