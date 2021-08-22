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
        VStack {
            Text("\(viewModel.count)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button("Start") {
                viewModel.startCounting()
            }
            .disabled(viewModel.isTimerRunning)
            
            Button("Stop") {
                viewModel.stopCounting()
            }
            .disabled(!viewModel.isTimerRunning)
            .padding()
            
            Button("Reset") {
                viewModel.resetCount()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
