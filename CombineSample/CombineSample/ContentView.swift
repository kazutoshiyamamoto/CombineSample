//
//  ContentView.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("\(viewModel.count)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                if viewModel.isCountingCompleted {
                    Text("Completed!")
                        .frame(width: 220, height: 50)
                        .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                        .cornerRadius(110)
                        .shadow(color: Color(red: 0.85, green: 0.85, blue: 0.85), radius: 20)
                        .position(x: geometry.size.width / 2, y: 30)
                        .transition(.move(edge: .top))
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
