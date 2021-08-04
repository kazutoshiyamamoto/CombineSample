//
//  ContentView.swift
//  CombineSample
//
//  Created by home on 2021/07/08.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("textA:\(viewModel.textA)")
                .padding()
            
            Text("textB:\(viewModel.textB)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
