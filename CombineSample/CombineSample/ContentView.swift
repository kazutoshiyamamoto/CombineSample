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
            TextField("Search", text: $viewModel.text, onCommit: { viewModel.onCommit() })
                .padding([.leading, .trailing], 25)
            
            List {
                ForEach(viewModel.users) { user in
                    RepositoriesListRowView(user: user)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(searchUserModel: SearchUserModel()))
    }
}
