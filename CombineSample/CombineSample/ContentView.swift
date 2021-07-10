//
//  ContentView.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI
import NotificationCenter

struct ContentView: View {
    let myNotification = Notification.Name("MyNotification")
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        Button(action: {
            NotificationCenter.default.post(name: myNotification, object: nil)
        }, label: {
            Text("通知を送信")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
