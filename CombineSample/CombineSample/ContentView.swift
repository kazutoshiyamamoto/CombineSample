//
//  ContentView.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI
import NotificationCenter

struct ContentView: View {
    let sampleNotification = Notification.Name("sampleNotification")
    
    
    init() {
        _ = NotificationCenter.default.addObserver(forName: sampleNotification, object: nil, queue: nil) { _ in
            print("Receive notification")
        }
        
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
