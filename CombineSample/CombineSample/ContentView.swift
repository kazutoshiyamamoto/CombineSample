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
    
    
    var body: some View {
        Button(action: {
            NotificationCenter.default.post(name: sampleNotification, object: nil)
        }, label: {
            Text("通知を送信")
        })
        .onAppear(perform: {
            let _ = NotificationCenter.default.addObserver(forName: myNotification, object: nil, queue: nil) { notification in
                print("通知を受信")
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
